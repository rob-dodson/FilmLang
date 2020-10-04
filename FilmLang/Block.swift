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
    var width         : CGFloat = 111.0
    var height        : CGFloat = 111.0
    var strokeWidth   : CGFloat = 2
    var rotation      : CGFloat = -999
    var debug         : Bool = false
    var gradientAngle : CGFloat = -90
    var clip          : Bool = false
    var radius        : CGFloat = 0.0
    var startAngle    : CGFloat = 0
    var endAngle      : CGFloat = 45
    var view          : NSView?
    var windowChanged : ((Block) -> Void)?
    var boundingRect  : NSRect? = nil
    var xoffset       : CGFloat = 0.0
    var yoffset       : CGFloat = 0.0
    var windowWidthOffset  : CGFloat = 0.0
    var windowHeightOffset : CGFloat = 0.0
    var fitToView          : Bool = false
    var layoutSpec         : LayoutSpec?
    
    
    init(name:String, view:NSView?)
    {
        self.name = name
        self.view = view
        
        self.children = [Block]()
        self.animators = [Animator]()
    }
    
    
    func animate()
    {
        for index in 0..<animators.count
        {
            if let winchange = animators[index].windowChanged
            {
                winchange(animators[index])
            }
            
            switch animators[index].val
            {
            case .x:
                adjust(val:&x, animator: &animators[index])
                
            case.y:
                adjust(val:&y, animator: &animators[index])
                
            case .rotation:
                adjust(val:&rotation, animator: &animators[index])
                
            case .radius:
                adjust(val:&radius, animator: &animators[index])
                
            case .startangle:
                adjust(val:&startAngle, animator: &animators[index])
                
            case .endangle:
                adjust(val:&endAngle, animator: &animators[index])
                
            case .fillalpha:
                if fillColor != nil
                {
                    var alpha = CGFloat(fillColor!.alphaComponent)
                    adjust(val:&alpha, animator: &animators[index])
                    fillColor = fillColor!.withAlphaComponent(CGFloat(alpha))
                }
            case .strokewidth:
                adjust(val:&strokeWidth, animator: &animators[index])
                
            case .strokealpha:
                adjust(val:&strokeAlpha, animator: &animators[index])
            }
        }
    }

    
    func adjust(val:inout CGFloat,animator:inout Animator)
    {
        if animator.type == .Inc
        {
            val = val + animator.amount
            if val > animator.max { val = animator.min }
        }
        else if animator.type == .Dec
        {
            val = val - animator.amount
            if val < animator.min { val = animator.max }
        }
        else if animator.type == .Bounce
        {
            val = val + animator.amount
            if val > animator.max
            {
                animator.amount = -animator.amount
            }
            else if val < animator.min
            {
                animator.amount = abs(animator.amount)
            }
        }
    }
    
    
    func addChild(block:Block)
    {
        children.append(block);
        block.parent = self;
    }
    
    
    func offset() -> (CGFloat,CGFloat)
    {
        var x : CGFloat = 0
        var y : CGFloat = 0
        
        var p = parent
        while p != nil
        {
            x = x + p!.x
            y = y + p!.y
            p = p?.parent
        }
        
        return (x,y)
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
        NSGraphicsContext.saveGraphicsState()
        
        if let windowchanged = windowChanged
        {
            windowchanged(self)
        }

        if self.layoutSpec != nil && Block.layoutGrid != nil
        {
            let gridrect = Block.layoutGrid.getGridRect(x: Int(self.layoutSpec!.x), y:Int(self.layoutSpec!.y))
            xoffset = gridrect.x
            yoffset = gridrect.y
        }
        else
        {
            (xoffset,yoffset) = offset()
        }
        boundingRect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)
        
        if rotation > -999
        {
            let context = NSGraphicsContext.current!.cgContext
            
            if let rect = boundingRect
            {
                context.translateBy(x:rect.origin.x, y:rect.origin.y)
                context.rotate(by: CGFloat(rotation) * CGFloat.pi/180)
                context.translateBy(x:-rect.origin.x, y:-rect.origin.y)
            }
        }
        
        if strokeAlpha > 0.0
        {
            strokeColor = strokeColor?.withAlphaComponent(strokeAlpha)
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
                .foregroundColor: NSColor.white,
                .paragraphStyle: rectangleStyle,
            ] as [NSAttributedString.Key: Any]
            name.draw(in: rect!.offsetBy(dx: 0, dy: -4), withAttributes: rectangleFontAttributes)
        }
        
        if clip == true && rect != nil
        {
            rect!.clip()
        }
        
        for block in children
        {
            block.draw()
        }
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
    
    static func addBlockFromDictionary(dict:NSDictionary, view:NSView)
    {
        if dict["type"] as! String == "Rect"
        {
            let rect = FLRect(name: dict["name"] as! String, view: view)
            rect.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Text"
        {
            let text = FLText(name: dict["name"] as! String, view: view)
            text.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Grid"
        {
            let grid = FLGrid(name: dict["name"] as! String, view: view)
            grid.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Image"
        {
            let image = FLImage(name: dict["name"] as! String, view: view)
            image.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Arc"
        {
            let arc = FLArc(name: dict["name"] as! String, view: view)
            arc.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Circle"
        {
            let circle = FLCircle(name: dict["name"] as! String, view: view)
            circle.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Line"
        {
            let line = FLLine(name: dict["name"] as! String, view: view)
            line.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Path"
        {
            let path = FLPath(name: dict["name"] as! String, view: view)
            path.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Bezier"
        {
            let bez = FLBezier(name: dict["name"] as! String, view: view)
            bez.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "Axis"
        {
            let bez = FLAxis(name: dict["name"] as! String, view: view)
            bez.parseBlock(dict: dict)
        }
        else if dict["type"] as! String == "LayoutGrid"
        {
            let layoutgrid = FLLayoutGrid(name: dict["name"] as! String, view: view)
            layoutgrid.parseBlock(dict: dict)
        }
        
    }
    
    
    //
    // override in child and call super.parseBlock() there
    //
    func parseBlock(dict:NSDictionary)
    {
        if let debug = dict["debug"]                 as? Bool    { self.debug = debug }
        if let clip = dict["clip"]                   as? Bool    { self.clip = clip }
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
                    block.x = self.view!.frame.width - block.windowWidthOffset
                    block.y = self.view!.frame.height - block.windowHeightOffset
                }
        }
        
        
        for i in 0...10
        {
            if let animatordict = dict["animator\(i)"] as? NSDictionary
            {
                let val    = animatordict["value"] as! String
                let amount = CGFloat.init(animatordict["amount"] as! Double)
                let min    = CGFloat.init(animatordict["min"] as! Double)
                let max    = CGFloat.init(animatordict["max"] as! Double)
                let type   = animatordict["type"] as! String
                
                var value = Animator.AnimatorVal.rotation
                if (val == "rotation")    { value = Animator.AnimatorVal.rotation }
                if (val == "x")           { value = Animator.AnimatorVal.x }
                if (val == "y")           { value = Animator.AnimatorVal.y }
                if (val == "startangle")  { value = Animator.AnimatorVal.startangle }
                if (val == "endangle")    { value = Animator.AnimatorVal.endangle }
                if (val == "strokewidth") { value = Animator.AnimatorVal.strokewidth }
                if (val == "strokealpha") { value = Animator.AnimatorVal.strokealpha }

                var anitype = Animator.AnimatorType.Bounce
                if (type == "bounce") { anitype = Animator.AnimatorType.Bounce }
                if (type == "inc")    { anitype = Animator.AnimatorType.Inc }
                if (type == "dec")    { anitype = Animator.AnimatorType.Dec }
                
                self.animators.append(Animator(val: value, amount: amount, min: min, max: max, type: anitype, windowChanged:nil))
                
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
                Block.addBlockFromDictionary(dict: childblockdict,view: view!)
            }
        }
    }
    
    
    static func connectParent(block:Block,dict:NSDictionary)
    {
        if let parent = dict["parent"] as? String
        {
            if let parentblock = findBlock(nametofind: parent, startblock: topBlock)
            {
                parentblock.addChild(block:block)
            }
            else
            {
                topBlock.addChild(block:block)
            }
        }
        else
        {
            topBlock.addChild(block:block)
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






