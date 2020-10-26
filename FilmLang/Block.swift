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
    static var thereAreAnimators  : Bool = false
    static var thereAreAnimations : Bool = false
    static var topBlock           : Block!
    static var layoutGrid         : FLLayoutGrid!
    static var view               : NSView!
    
    var parent        : Block?
    var children      : [Block]
    var name          : String
    var x             : CGFloat = 10.0
    var y             : CGFloat = 10.0
    var z             : CGFloat = 0
    var fillColor     : NSColor?
    var strokeColor   : NSColor?
    var strokeAlpha   : CGFloat = -1.0
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
    var lineCap       : CAShapeLayerLineCap = .square
    var windowChanged : ((Block) -> Void)?
    var boundingRect  : NSRect!
    var xoffset       : CGFloat = 0.0
    var yoffset       : CGFloat = 0.0
    var windowWidthOffset  : CGFloat = 0.0
    var windowHeightOffset : CGFloat = 0.0
    var fitToView     : Bool = false
    var layoutSpec    : LayoutSpec?
    var viewPadding   : CGFloat = 20
    var scrollAmount  : CGFloat = 0.0
    var baseLayer     : CALayer!
    var hidden        : Bool = false
    var built         : Bool = false
    
    var animations    : [Animation]
    
    
    init(name:String)
    {
        self.name = name
        self.children = [Block]()
        self.animations = [Animation]()
        
        createBaseLayer()
    }
    
    func setLayerDefaults(layer:CALayer)
    {
        layer.zPosition = z
    }
    
    func setColorsOnShapeLayer(layer:CAShapeLayer)
    {
        if let strokecolor = strokeColor
        {
            layer.strokeColor = strokecolor.cgColor
            layer.lineWidth = strokeWidth
        }
        if let fillcolor = fillColor
        {
            layer.fillColor = fillcolor.cgColor
        }
        else
        {
            layer.fillColor = nil
        }
    }
    
    func createBaseLayer()
    {
        baseLayer = CALayer()
        baseLayer.layoutManager = CAConstraintLayoutManager()
        baseLayer.isHidden = hidden
    }
    
    func animationGoing() -> Bool
    {
        
        return false
    }
    
    
    func runAnimations()
    {
        if animations.count > 0
        {
            for animation in animations
            {
                animation.startAnimation()
            }
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
            let rotationTransform = CATransform3DMakeRotation(CGFloat(rotation * CGFloat.pi / 180), 0.0, 0.0, 1.0)
            baseLayer.transform = rotationTransform
        }
        /*
        if let layout = layoutSpec
        {
            if layout.fit == true
            {
                if let gridrect = Block.layoutGrid.getGridRect(x: layout.x,y:layout.y)
                {
                    if width > 0.0 && height > 0.0
                    {
                        let scaleAmtWidth =  gridrect.width / width
                        let scaleAmtHeight =  gridrect.height / height
                        let scaleTransform = CATransform3DMakeScale(scaleAmtWidth, scaleAmtHeight, 1.0)
                        if rotation > -999
                        {
                            baseLayer.transform = CATransform3DConcat(baseLayer.transform,scaleTransform)
                        }
                        else
                        {
                            baseLayer.transform = scaleTransform
                        }
                    }
                }
            }
        }
 */
       
    }
    
    func buildBasicRect() -> CALayer
    {
        let rectLayer = CALayer()
        
        let rect = CGRect(x: 0, y: 0,width: width, height: height)
        rectLayer.bounds = rect
        
       // rectLayer.masksToBounds = clip
        
        if let strokecolor = strokeColor
        {
            rectLayer.borderColor = strokecolor.cgColor
            rectLayer.borderWidth = strokeWidth
            rectLayer.cornerRadius = radius
        }
        
        if let fillcolor = fillColor
        {
            rectLayer.backgroundColor = fillcolor.cgColor
        }
        
       
        if let fillgradient = fillGradient
        {
            let gradlayer = CAGradientLayer()
            gradlayer.bounds = rect
            gradlayer.cornerRadius = radius
            var color0 = NSColor()
            var color1 = NSColor()
            fillgradient.getColor(&color0, location: nil, at: 0)
            fillgradient.getColor(&color1, location: nil, at: 1)
            gradlayer.colors = [color0.cgColor,color1.cgColor]
            addLayerConstraints(layer:gradlayer)
            baseLayer.addSublayer(gradlayer)
        }
        
        baseLayer.bounds = rect
        addLayerConstraints(layer:rectLayer)
        baseLayer.addSublayer(rectLayer)
        
        Block.addLayerToParent(block: self, layer: baseLayer)
        
        return rectLayer
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
            
            name.draw(in: rect!.offsetBy(dx:0, dy:0), withAttributes: rectangleFontAttributes)
            
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
        let type = dict["type"] as! String
        let name = dict["name"] as! String
        
        
        if type == "Rect"
        {
            let rect = FLRect(name: name)
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
        else if type == "Text"
        {
            let text = FLText(name: name)
            text.parseBlock(dict: dict)
        }
        else if type == "Grid"
        {
            let grid = FLGrid(name: name)
            grid.parseBlock(dict: dict)
        }
        else if type == "Image"
        {
            let image = FLImage(name: name)
            image.parseBlock(dict: dict)
        }
        else if type == "Arc"
        {
            let arc = FLArc(name: name)
            arc.parseBlock(dict: dict)
        }
        else if type == "Circle"
        {
            let circle = FLCircle(name: name)
            circle.parseBlock(dict: dict)
        }
        else if type == "Line"
        {
            let line = FLLine(name: name)
            line.parseBlock(dict: dict)
        }
        else if type == "Path"
        {
            let path = FLPath(name: name)
            path.parseBlock(dict: dict)
        }
        else if type == "Bezier"
        {
            let bez = FLBezier(name: name)
            bez.parseBlock(dict: dict)
        }
        else if type == "Axis"
        {
            let bez = FLAxis(name: name)
            bez.parseBlock(dict: dict)
        }
        else if type == "LayoutGrid"
        {
            let layoutgrid = FLLayoutGrid(name: name)
            layoutgrid.parseBlock(dict: dict)
        }
        else if type == "SceneView"
        {
            let sceneview = FLScene(name: name)
            sceneview.parseBlock(dict: dict)
        }
        else if type == "ScrollText"
        {
            let scrolltext = FLScrollText(name: name)
            scrolltext.parseBlock(dict: dict)
        }
        else
        {
            print("Error: Unknown type: \(type) \(name)")
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
        if let z = dict["z"]                         as? CGFloat { self.z = z }
        if let width = dict["width"]                 as? CGFloat { self.width = width }
        if let height = dict["height"]               as? CGFloat { self.height = height }
        if let fillcolordict = dict["fillColor"]     as? NSDictionary { self.fillColor = Block.colorFromDict(dict: fillcolordict) }
        if let strokecolordict = dict["strokeColor"] as? NSDictionary { self.strokeColor = Block.colorFromDict(dict: strokecolordict) }
        if let radius = dict["radius"]               as? CGFloat { self.radius = radius }
        if let rotation = dict["rotation"]           as? CGFloat { self.rotation = rotation }
        if let strokeWidth = dict["strokeWidth"]     as? CGFloat { self.strokeWidth = strokeWidth }
        if let gradientAngle = dict["gradientAngle"] as? CGFloat { self.gradientAngle = gradientAngle }
        if let hidden = dict["hidden"]               as? Bool    { self.hidden = hidden }
        
        
        if let lineCap = dict["lineCap"]             as? String
        {
            if lineCap == "round"
            {
                self.lineCap = .round
            }
            else if lineCap == "square"
            {
                self.lineCap = .square
            }
            else if lineCap == "butt"
            {
                self.lineCap = .butt
            }
        }
        
        
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
            if let dict = dict["animation\(i)"] as? NSDictionary
            {
                let animation = Animation.animationFromDict(dict:dict)
                animations.append(animation)
                Block.thereAreAnimations = true
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






