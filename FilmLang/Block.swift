//
//  BlockProtocol.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/13/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


struct LayoutSpec
{
    internal init(x: Int, y: Int, fit: Bool)
    {
        self.x = x
        self.y = y
        self.fit = fit
    }
    
    let x : Int
    let y : Int
    let fit : Bool
}

class Block
{
    static var thereAreAnimators : Bool = false
    static var topBlock          : Block!
    static var layoutGrid        : FLLayoutGrid!
    static var view              : NSView!
    
    var parent        : Block?
    var children      : [Block]
    var name          : String
    var x             : CGFloat = 10.0
    var y             : CGFloat = 10.0
    var fillColor     : NSColor?
    var strokeColor   : NSColor?
    var strokeAlpha   : CGFloat = -1.0
    var animators     : [Animator]
    var fillGradient  : NSGradient?
    var width         : CGFloat = 0.0
    var height        : CGFloat = 0.0
    var strokeWidth   : CGFloat = 2
    var rotation      : CGFloat = -999
    var debug         : Bool = false
    var gradientAngle : CGFloat = -90
    var clip          : Bool = false
    var radius        : CGFloat = 0.0
    var startAngle    : CGFloat = 0
    var endAngle      : CGFloat = 45
    var windowChanged : ((Block) -> Void)?
    var boundingRect  : NSRect!
    var xoffset       : CGFloat = 0.0
    var yoffset       : CGFloat = 0.0
    var windowWidthOffset  : CGFloat = 0.0
    var windowHeightOffset : CGFloat = 0.0
    var fitToView          : Bool = false
    var layoutSpec         : LayoutSpec?
    var viewPadding        : CGFloat = 20
    var scrollAmount       : CGFloat = 0.0
    var baseLayer          : CALayer!
    var hidden             : Bool = false
    
    
    init(name:String)
    {
        self.name = name
        self.children = [Block]()
        self.animators = [Animator]()
        
        createBaseLayer()
    }
    
    
    func createBaseLayer()
    {
        baseLayer = CALayer()
        baseLayer.layoutManager = CAConstraintLayoutManager()
        baseLayer.isHidden = hidden
    }
    
    
    func animate()
    {
        for index in 0..<animators.count
        {
            if let winchange = animators[index].windowChanged
            {
                winchange(animators[index])
            }
            
            Animator.adjustBlockForAnimation(animator: &animators[index], block: self)
           
        }
    }

    func addLayerConstraints(layer:CALayer)
    {
        layer.addConstraint(CAConstraint(attribute: .midX, relativeTo: "superlayer", attribute:.midX))
        layer.addConstraint(CAConstraint(attribute: .midY, relativeTo: "superlayer", attribute:.midY))
        layer.addConstraint(CAConstraint(attribute: .width, relativeTo: "superlayer", attribute:.width))
        layer.addConstraint(CAConstraint(attribute: .height, relativeTo: "superlayer", attribute:.height))
    }
    
    
    
    
    static func addLayerToParent(block:Block, layer:CALayer)
    {
        if let parent = block.parent
        {
            parent.baseLayer.addSublayer(layer)
        }
        else // No parent? Add this layer to the main view's layer.
        {
            Block.view.layer?.addSublayer(layer)
        }
    }
    
    
    func addChild(childblock:Block)
    {
        children.append(childblock);
        childblock.parent = self;
    }
    
    
    func offset() -> (CGFloat,CGFloat)
    {
        if let layout = layoutSpec
        {
            if let gridrect = Block.layoutGrid.getGridRect(x: layout.x,y:layout.y)
            {
                return (gridrect.x,gridrect.y)
            }
        }
        
        return (0,0)
    }
    
    
    //
    // subclass must override
    //
    func draw()
    {
        preDraw()
        
        postDraw(rect: nil)
    }
   
    
    //
    // must be called from subclass's draw().
    // postDraw will draw children
    //
    func preDraw()
    {
        if let windowchanged = windowChanged
        {
            windowchanged(self)
        }

        (xoffset,yoffset) = offset()
        boundingRect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)
        
        if strokeAlpha > 0.0
        {
            strokeColor = strokeColor?.withAlphaComponent(strokeAlpha)
        }
        
        if rotation > -999
        {
            let transform = CATransform3DMakeRotation(CGFloat(rotation * CGFloat.pi / 180), 0.0, 0.0, 1.0)
            baseLayer.transform = transform
        }
    }
    
    func postDraw(rect:NSRect?)
    {
        if debug == true && rect != nil
        {
            let rectangleStyle = NSMutableParagraphStyle()
            rectangleStyle.alignment = .center
            let rectangleFontAttributes = [
                .font: NSFont(name: "Futura", size: 12)!,
                .foregroundColor: NSColor.gray,
                .paragraphStyle: rectangleStyle,
            ] as [NSAttributedString.Key: Any]
            
            name.draw(in: rect!.offsetBy(dx: 0, dy: -4), withAttributes: rectangleFontAttributes)
        }
        
        if clip == true
        {
            baseLayer.masksToBounds = true
        }
        
        for block in children
        {
            block.draw()
        }
    }
    
    
    static func addBlockFromDictionary(dict:NSDictionary)
    {
        if dict["type"] as! String == "Rect"
        {
            let rect = FLRect(name: dict["name"] as! String)
            rect.parseBlock(dict: dict)
            
            if rect.name == "Screen"
            {
                Block.topBlock = rect
                Block.topBlock.fitToView = true
                rect.x = (Block.view?.frame.origin.x)! + rect.viewPadding
                rect.y = (Block.view?.frame.origin.y)! + rect.viewPadding
                rect.width = (Block.view?.frame.width)! - (rect.viewPadding * 2)
                rect.height = (Block.view?.frame.height)! - (rect.viewPadding * 2)
                
                Block.topBlock.windowChanged =
                {(block) -> Void in
                    block.width = (Block.view?.frame.width)! - (block.viewPadding * 2)
                    block.height = (Block.view?.frame.height)! - (block.viewPadding * 2)
                }
                
            }
        }
        else if dict["type"] as! String == "Text"
        {
            let text = FLText(name: dict["name"] as! String)
            text.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Grid"
        {
            let grid = FLGrid(name: dict["name"] as! String)
            grid.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Image"
        {
            let image = FLImage(name: dict["name"] as! String)
            image.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Arc"
        {
            let arc = FLArc(name: dict["name"] as! String)
            arc.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Circle"
        {
            let circle = FLCircle(name: dict["name"] as! String)
            circle.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Line"
        {
            let line = FLLine(name: dict["name"] as! String)
            line.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Path"
        {
            let path = FLPath(name: dict["name"] as! String)
            path.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Bezier"
        {
            let bez = FLBezier(name: dict["name"] as! String)
            bez.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Axis"
        {
            let bez = FLAxis(name: dict["name"] as! String)
            bez.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "LayoutGrid"
        {
            let layoutgrid = FLLayoutGrid(name: dict["name"] as! String)
            layoutgrid.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "SceneView"
        {
            let sceneview = FLScene(name: dict["name"] as! String)
            sceneview.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "ScrollText"
        {
            let scrolltext = FLScrollText(name: dict["name"] as! String)
            scrolltext.parseBlock(dict: dict)
        }
    }
    
    
    //
    // override in child and call super.parseBlock() there
    //
    func parseBlock(dict:NSDictionary)
    {
        if let debug = dict["debug"]                 as? Bool    { self.debug = debug }
        if let clip = dict["clip"]                   as? Bool    { self.clip = clip }
        if let fit = dict["fitToView"]               as? Bool    { self.fitToView = fit }
        if let x = dict["x"]                         as? CGFloat { self.x = x }
        if let y = dict["y"]                         as? CGFloat { self.y = y }
        if let width = dict["width"]                 as? CGFloat { self.width = width }
        if let height = dict["height"]               as? CGFloat { self.height = height }
        if let fillcolordict = dict["fillColor"]     as? NSDictionary { self.fillColor = Block.colorFromDict(dict: fillcolordict) }
        if let strokecolordict = dict["strokeColor"] as? NSDictionary { self.strokeColor = Block.colorFromDict(dict: strokecolordict) }
        if let radius = dict["radius"]               as? CGFloat { self.radius = radius }
        if let rotation = dict["rotation"]           as? CGFloat { self.rotation = rotation }
        if let strokeWidth = dict["strokeWidth"]     as? CGFloat { self.strokeWidth = strokeWidth }
        if let gradientAngle = dict["gradientAngle"] as? CGFloat { self.gradientAngle = gradientAngle }
        if let scrollamount = dict["scrollAmount"]   as? CGFloat { self.scrollAmount = scrollamount }
        if let hidden = dict["hidden"]               as? Bool    { self.hidden = hidden }
        
        baseLayer.isHidden = hidden
        
        if let layout = dict["layoutSpec"] as? NSDictionary
        {
            let x = layout["x"] as! Int
            let y = layout["y"] as! Int
            let fit = layout["fit"] as! Bool
            self.layoutSpec = LayoutSpec(x: x, y: y, fit: fit)
        }
        
        
        if let fillGradient = dict["fillGradient"] as? NSDictionary
        {
            let fromColor = Block.colorFromDict(dict: fillGradient["startColor"] as! NSDictionary)
            let toColor = Block.colorFromDict(dict: fillGradient["endColor"] as! NSDictionary)
            
            self.fillGradient = NSGradient(starting: fromColor, ending: toColor)
        }
        
        
        if let windowOffset = dict["windowOffset"] as? NSDictionary
        {
            let point = Block.pointFromDict(dict: windowOffset)
            self.windowWidthOffset = point.x
            self.windowHeightOffset = point.y
            self.windowChanged =
                {(block) -> Void in
                    block.x = Block.view.frame.width - block.windowWidthOffset
                    block.y = Block.view.frame.height - block.windowHeightOffset
                }
        }
        
        
        for i in 0...10
        {
            if let animatordict = dict["animator\(i)"] as? NSDictionary
            {
                let animator = Animator.animatorFromDict(dict:animatordict)
                self.animators.append(animator)
                Block.thereAreAnimators = true
            }
        }

        if let thistype = self as? FLLayoutGrid
        {
            Block.layoutGrid = thistype
        }
        else
        {
            Block.connectParent(block:self,dict: dict)
        }

        for i in 0...10
        {
            if let childblockdict = dict["childBlock\(i)"] as? NSDictionary
            {
                childblockdict.setValue(self.name, forKey:"parent")
                Block.addBlockFromDictionary(dict: childblockdict)
            }
        }
    }
    
    
    static func connectParent(block:Block,dict:NSDictionary)
    {
        if let parent = dict["parent"] as? String
        {
            if let parentblock = findBlock(nametofind: parent, startblock: topBlock)
            {
                parentblock.addChild(childblock:block)
            }
            else
            {
                topBlock.addChild(childblock:block)
            }
        }
        else
        {
            if block.name == "Screen"
            {
                topBlock = block
            }
            else
            {
                topBlock.addChild(childblock:block)
            }
        }
    }
    
    
    static func findBlock(nametofind:String,startblock:Block) -> Block?
    {
        for childblock in startblock.children
        {
            if childblock.name == nametofind
            {
                return childblock
            }
        }
        
        for childblock in startblock.children
        {
            if childblock.children.count > 0
            {
                if let block = findBlock(nametofind: nametofind, startblock: childblock)
                {
                    return block
                }
            }
        }
        
        return nil
    }
    
   
    
    
    static func pointFromDict(dict:NSDictionary) -> NSPoint
    {
        let x = CGFloat.init(dict["x"] as! Double)
        let y = CGFloat.init(dict["y"] as! Double)
        
        return NSPoint(x: x, y: y)
    }
    
    static func colorFromDict(dict:NSDictionary) -> NSColor
    {
        let red = CGFloat.init(dict["red"] as! Double)
        let green = CGFloat.init(dict["green"] as! Double)
        let blue = CGFloat.init(dict["blue"] as! Double)
        let alpha = CGFloat.init(dict["alpha"] as! Double)
        
        return NSColor.init(calibratedRed: red, green: green, blue: blue, alpha: alpha)
    }
    
}






