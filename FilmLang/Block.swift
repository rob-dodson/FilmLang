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
    static var thereAreAnimations : Bool = false
    static var topBlock           : Block!
    static var layoutGrid         : FLLayoutGrid!
    static var view               : NSView!
    static var screenScale        : CGFloat = 0.0
    
    
    var type          : String
    var name          : String
    var parent        : Block?
    var children      : [Block]
    var x             : CGFloat = 0.0
    var y             : CGFloat = 0.0
    var z             : CGFloat = 0.0
    var width         : CGFloat = 0.0
    var height        : CGFloat = 0.0
    var fillColor     : NSColor?
    var strokeColor   : NSColor?
    var strokeAlpha   : CGFloat = -1.0
    var fillGradient  : NSGradient?
    var strokeWidth   : CGFloat = 2
    var strokeStart   : CGFloat = 0.0
    var strokeEnd     : CGFloat = 1.0
    var rotation      : CGFloat = -999
    var debug         : Bool = false
    var gradientAngle : CGFloat = 180.0
    var clip          : Bool = false
    var radius        : CGFloat = 0.0
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
    var center        : Bool = false
    var debugColor    : NSColor = NSColor.red
    var debugFont     : String = "Helvetica"
    var debugFontSize : CGFloat = 18.0
    var waitStartSecs : Double = -1.0
    var waitEndSecs   : Double = 0.0
    var closePath     : Bool = false
    var scalePath     : CGFloat = 1.0
    var timer         : Timer?
    var started       : Bool = false
    var scale         : CGFloat = 0.0
    var transformsDone: Bool = false
    
    
    init(name:String,type:String)
    {
        self.name = name
        self.type = type
        self.children = [Block]()
        self.animations = [Animation]()
        
        createBaseLayer()
    }
    

    func newCALayer() -> CALayer
    {
        let layer = CALayer()
        layer.zPosition = z
        
        return layer
    }
    
    
    func newCAShapeLayer() -> CAShapeLayer
    {
        let layer = CAShapeLayer()
        layer.zPosition = z
        layer.strokeStart = strokeStart
        layer.strokeEnd = strokeEnd
        layer.lineCap = lineCap
        
        return layer
    }
    
    
    func newCAGradientLayer() -> CAGradientLayer
    {
        let layer = CAGradientLayer()
        layer.zPosition = z

        return layer
    }
    
    func newCATextLayer() -> CATextLayer
    {
        let layer = CATextLayer()
        layer.zPosition = z

        return layer
    }
    
    func newCAScrollLayer() -> CAScrollLayer
    {
        let layer = CAScrollLayer()
        layer.zPosition = z

        return layer
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
        else if let fillgradient = fillGradient // not currently working
        {
            let gradlayer = newCAGradientLayer()
            
            gradlayer.bounds = layer.bounds
            gradlayer.cornerRadius = radius
            var color0 = NSColor()
            var color1 = NSColor()
            fillgradient.getColor(&color0, location: nil, at: 0)
            fillgradient.getColor(&color1, location: nil, at: 1)
            gradlayer.colors = [color0.cgColor,color1.cgColor]
            gradlayer.transform = CATransform3DMakeRotation(gradientAngle * (3.14159 / 180.0), 0, 0, 1)
            
            addLayerConstraints(layer:gradlayer)
            baseLayer.addSublayer(gradlayer)
            
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
        
        block.setDebug()
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
        print("draw() Sub class must override")
        
    }
   
    //
    // subclass may override
    //
    func start()
    {
    }
    
    func end()
    {
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
        
        
        //
        // one time transforms
        //
        if transformsDone == false
        {
            baseLayer.transform = CATransform3DIdentity
            if rotation > -999
            {
                let rotationTransform = CATransform3DMakeRotation(CGFloat(rotation * CGFloat.pi / 180), 0.0, 0.0, 1.0)
                baseLayer.transform = CATransform3DConcat(baseLayer.transform, rotationTransform)
            }
            
            if scale > 0.0
            {
                let scaleTransform = CATransform3DMakeScale(scale,scale,0.0)
                baseLayer.transform = CATransform3DConcat(baseLayer.transform, scaleTransform)
            }
            
            if Block.screenScale > 0.0
            {
                let scaleTransform = CATransform3DMakeScale(Block.screenScale,Block.screenScale,0.0)
                baseLayer.transform = CATransform3DConcat(baseLayer.transform, scaleTransform)
            }
            
            transformsDone = true;
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
        let rectLayer = newCALayer()

        let rect = CGRect(x: 0, y: 0,width: width.rounded(), height: height.rounded())
        rectLayer.bounds = rect
       
    
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
            let gradlayer = newCAGradientLayer()
            
            gradlayer.bounds = rect
            gradlayer.cornerRadius = radius
            var color0 = NSColor()
            var color1 = NSColor()
            fillgradient.getColor(&color0, location: nil, at: 0)
            fillgradient.getColor(&color1, location: nil, at: 1)
            gradlayer.colors = [color0.cgColor,color1.cgColor]
            gradlayer.transform = CATransform3DMakeRotation(gradientAngle * (3.14159 / 180.0), 0, 0, 1)
            
            addLayerConstraints(layer:gradlayer)
            baseLayer.addSublayer(gradlayer)
            
        }
        
        baseLayer.bounds = rect
        addLayerConstraints(layer:rectLayer)
        baseLayer.addSublayer(rectLayer)
        
        Block.addLayerToParent(block: self, layer:baseLayer)
        
        return rectLayer
    }
      
    
    func setDebug()
    {
        if debug == true
        {
            baseLayer.borderColor = debugColor.cgColor
            baseLayer.borderWidth = 1.0
            
            
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .center
            let textFontAttributes = [
                .font: NSFont(name: debugFont, size: debugFontSize)!,
                .foregroundColor: debugColor.cgColor,
                .paragraphStyle: textStyle,
            ] as [NSAttributedString.Key: Any]
            
            let textBoundingRect = name.boundingRect(with: NSSize(width: CGFloat.infinity,
                                                                  height: CGFloat.infinity),
                                                     options: .usesLineFragmentOrigin,
                                                     attributes: textFontAttributes)
            
            
            let textLayer = newCATextLayer()
            textLayer.bounds = CGRect(x: 0 , y: 0 , width:textBoundingRect.width, height:textBoundingRect.height )
            textLayer.position = CGPoint(x:width / 2, y: height - 10)
            textLayer.fontSize = debugFontSize
            textLayer.font = CGFont(debugFont as CFString)
            textLayer.foregroundColor = debugColor.cgColor
            textLayer.string = name
            
            baseLayer.addSublayer(textLayer)
        }
    }
        
    
    func postDraw()
    {
        //
        // start timers, etc for blocks that don't have a waitStartSecs
        //
        if started == false && waitStartSecs < 0.0
        {
            start()
            started = true
        }
        
        
        //
        // update bounds and position
        //
        baseLayer.bounds = CGRect(x: 0, y: 0,width: width, height: height)
        baseLayer.position = CGPoint(x: x + xoffset + (width / 2), y: y + yoffset + (height / 2))
        
        
        //
        // centering
        //
        if center == true
        {
            if let layout = layoutSpec
            {
                if let gridrect = Block.layoutGrid.getGridRect(x: layout.x,y:layout.y)
                {
                    baseLayer.position = CGPoint(x: x + xoffset + (gridrect.width / 2), y: y + yoffset + (gridrect.height / 2))
                }
            }
            else
            {
                baseLayer.position = CGPoint(x: x + xoffset + (parent!.width / 2), y: y + yoffset + (parent!.height / 2))
            }
        }
        
        
        //
        // clipping
        //
        if clip == true
        {
            baseLayer.masksToBounds = true
        }
        
        
        //
        // render children
        //
        for childblock in children
        {
            childblock.draw()
        }
    }
    
    
    //
    // main addBlock() parsing entry point. Create a block type and call it to parse itself.
    //
    static func addBlockFromDictionary(dict:NSDictionary)
    {
        let type = dict["type"] as! String
        let name = dict["name"] as! String
        
        
        if type == "Rect"
        {
            let rectblock = FLRect(name: name,type:type)
            rectblock.parseBlock(dict: dict)
            
            if rectblock.name == "Screen" // all filmlang scripts need a Screen block
            {
                
                Block.topBlock = rectblock
                Block.topBlock.fitToView = true
                Block.screenScale = rectblock.scale
                
                rectblock.x = (Block.view?.frame.origin.x)! + rectblock.viewPadding
                rectblock.y = (Block.view?.frame.origin.y)! + rectblock.viewPadding
                rectblock.width = (Block.view?.frame.width)! - (rectblock.viewPadding * 2)
                rectblock.height = (Block.view?.frame.height)! - (rectblock.viewPadding * 2)
               
                
                
                Block.topBlock.windowChanged =
                {(block) -> Void in
                    block.width = (Block.view?.frame.width)! - (block.viewPadding * 2)
                    block.height = (Block.view?.frame.height)! - (block.viewPadding * 2)
                }
            }
        }
        else if type == "Text"
        {
            let text = FLText(name: name,type:type)
            text.parseBlock(dict: dict)
        }
        else if type == "Grid"
        {
            let grid = FLGrid(name: name,type:type)
            grid.parseBlock(dict: dict)
        }
        else if type == "Image"
        {
            let image = FLImage(name: name,type:type)
            image.parseBlock(dict: dict)
        }
        else if type == "Circle"
        {
            let circle = FLCircle(name: name,type:type)
            circle.parseBlock(dict: dict)
        }
        else if type == "Line"
        {
            let line = FLLine(name: name,type:type)
            line.parseBlock(dict: dict)
        }
        else if type == "Path"
        {
            let path = FLPath(name: name,type:type)
            path.parseBlock(dict: dict)
        }
        else if type == "Bezier"
        {
            let bez = FLBezier(name: name,type:type)
            bez.parseBlock(dict: dict)
        }
        else if type == "Axis"
        {
            let bez = FLAxis(name: name,type:type)
            bez.parseBlock(dict: dict)
        }
        else if type == "LayoutGrid"
        {
            let layoutgrid = FLLayoutGrid(name: name,type:type)
            layoutgrid.parseBlock(dict: dict)
        }
        else if type == "SceneView"
        {
            let sceneview = FLScene(name: name,type:type)
            sceneview.parseBlock(dict: dict)
        }
        else if type == "ScrollText"
        {
            let scrolltext = FLScrollText(name: name,type:type)
            scrolltext.parseBlock(dict: dict)
        }
        else if type == "Sound"
        {
            let sound = FLSoundFile(name: name,type:type)
            sound.parseBlock(dict: dict)
        }
        else if type == "Number"
        {
            let number = FLNumber(name: name,type:type)
            number.parseBlock(dict: dict)
        }
        else
        {
            print("Error: Unknown type: \(type) \(name)")
        }
    }
    
    
    //
    // Parse the common shared parameters.
    // override in child and call super.parseBlock() there.
    //
    func parseBlock(dict:NSDictionary)
    {
        if let debug = dict["debug"]                 as? Bool    { self.debug = debug }
        if let debugColorDict = dict["debugColor"]   as? NSDictionary { self.debugColor = Block.colorFromDict(dict: debugColorDict) }
        if let debugFontSize = dict["debugFontSize"] as? CGFloat { self.debugFontSize = debugFontSize }
        if let debugFont = dict["debugFont"]         as? String  { self.debugFont = debugFont }
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
        if let strokeStart = dict["strokeStart"]     as? CGFloat { self.strokeStart = strokeStart }
        if let strokeEnd = dict["strokeEnd"]         as? CGFloat { self.strokeEnd = strokeEnd }
        if let gradientAngle = dict["gradientAngle"] as? CGFloat { self.gradientAngle = gradientAngle }
        if let hidden = dict["hidden"]               as? Bool    { self.hidden = hidden }
        if let center = dict["center"]               as? Bool    { self.center = center }
        if let closepath = dict["closePath"]         as? Bool    { self.closePath = closepath }
        if let scalepath = dict["scalePath"]         as? CGFloat { self.scalePath = scalepath }
        if let scale = dict["scale"]                 as? CGFloat { self.scale = scale }
        
        
        
        if let waitstartsecs = dict["waitStartSeconds"] as? Double
        {
            waitStartSecs = waitstartsecs
            
            self.hidden = true
            self.baseLayer.isHidden = true
            
            Timer.scheduledTimer(withTimeInterval: waitStartSecs, repeats: false)
            { (timer) in
                self.hidden = false
                self.baseLayer.isHidden = false
                
                self.start()
                self.runAnimations()
            }
        }
        
        if let waitendsecs = dict["waitEndSeconds"] as? Double
        {
            waitEndSecs = waitendsecs
            
            Timer.scheduledTimer(withTimeInterval: waitendsecs, repeats: false)
            { (timer) in
                self.hidden = true
                self.baseLayer.isHidden = true
                
                for animation in self.animations
                {
                    animation.layer.removeAllAnimations()
                }
                
                if self.timer != nil
                {
                    self.timer!.invalidate()
                }
                
                self.end()
            }
        }
       
        
        if let lineCap = dict["lineCap"] as? String
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
        
        
        if let layout = dict["layoutSpec"] as? NSDictionary
        {
            let x = layout["x"] as! Int
            let y = layout["y"] as! Int
            let fit = layout["fit"] as! Bool // not currently used
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
        
        
        for i in 0...10 // max of 10 animations per block
        {
            if let dict = dict["animation\(i)"] as? NSDictionary
            {
                let animation = Animation.animationFromDict(type:type,dict:dict)
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

        for i in 0...10 // max of 10 children per block
        {
            if let childblockdict = dict["childBlock\(i)"] as? NSDictionary
            {
                childblockdict.setValue(self.name, forKey:"parent")
                Block.addBlockFromDictionary(dict: childblockdict)
            }
        }
        
        if strokeAlpha > 0.0
        {
            strokeColor = strokeColor?.withAlphaComponent(strokeAlpha)
        }
        
       
    }
    
    
    func addDebugRect(point:CGPoint,color:NSColor)
    {
        let rect = FLRect(name: "debug",type:"RECT")
        rect.width = 5
        rect.height = 5
        rect.x = point.x
        rect.y = point.y
        rect.fillColor = color
        self.addChild(childblock: rect)
    }
    
    
    static func connectParent(block:Block,dict:NSDictionary)
    {
        if let parent = dict["parent"] as? String
        {
            if let parentblock = findBlock(nametofind: parent, startblock: topBlock) // make sure each block has a unique name so child can find correct parent
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
    

    static func rectFromDict(dict:NSDictionary) -> CGRect
    {
        let x = CGFloat.init(dict["x"] as? Double ?? 0.0)
        let y = CGFloat.init(dict["y"] as? Double ?? 0.0)
        let width = CGFloat.init(dict["width"] as? Double ?? 10.0)
        let height = CGFloat.init(dict["height"] as? Double ?? 10.0)
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    static func pointFromDict(dict:NSDictionary) -> NSPoint
    {
        let x = CGFloat.init(dict["x"] as? Double ?? 0.0)
        let y = CGFloat.init(dict["y"] as? Double ?? 0.0)
        
        return NSPoint(x: x, y: y)
    }
 
    
    static func colorFromDict(dict:NSDictionary) -> NSColor
    {
        let red = CGFloat.init(dict["red"] as? Double ?? 0.5)
        let green = CGFloat.init(dict["green"] as? Double ?? 0.5)
        let blue = CGFloat.init(dict["blue"] as? Double ?? 0.5)
        let alpha = CGFloat.init(dict["alpha"] as? Double ?? 1.0)
        
        return NSColor.init(calibratedRed: red, green: green, blue: blue, alpha: alpha)
    }
    
}






