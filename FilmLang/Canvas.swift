//
//  Canvas.swift
//  GraphToad
//
//  Created by Robert Dodson on 9/9/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Cocoa

class Canvas: NSView
{
    var timer : Timer? = nil
    let screenBlock : FLGrid

    
    func addBlockFromDictionary(dict:NSDictionary)
    {
        if dict["type"] as! String == "Rect"
        {
            let rect = FLRect(name: dict["name"] as! String, view: self)
            
            //rect.clip = true
            
            if let x = dict["x"]                  as? CGFloat { rect.x = x }
            if let y = dict["y"]                  as? CGFloat { rect.y = y }
            if let width = dict["width"]          as? CGFloat { rect.width = width }
            if let height = dict["height"]        as? CGFloat { rect.height = height }
            if let colorstr = dict["fillColor"]   as? String  { rect.fillColor = colorFromString(colorstr: colorstr) }
            if let colorstr = dict["strokeColor"]    as? String  { rect.strokeColor = colorFromString(colorstr: colorstr) }
            if let radius = dict["radius"]           as? CGFloat { rect.radius = radius }
            if let rotation = dict["rotation"]           as? CGFloat { rect.rotation = rotation }
            if let strokeWidth = dict["strokeWidth"] as? CGFloat { rect.strokeWidth = strokeWidth }
           
            connectParent(block: rect, dict: dict)
        }
        else if dict["type"] as! String == "Text"
        {
            let text = FLText(name: dict["name"] as! String, view: self)
            
            text.strokeColor = nil
            text.clip = true
            
            if let x = dict["x"]          as? CGFloat { text.x = x }
            if let y = dict["y"]          as? CGFloat { text.y = y }
            if let textstr = dict["text"] as? String { text.text = textstr }
            if let colorstr = dict["textColor"]    as? String  { text.textColor = colorFromString(colorstr: colorstr) }
            if let size = dict["size"]          as? CGFloat { text.size = size }
            
            connectParent(block: text, dict: dict)
        }
    }
    
    
    func connectParent(block:Block,dict:NSDictionary)
    {
        if let parent = dict["parent"] as? String
        {
            if let parentblock = findBlock(nametofind: parent, block: screenBlock)
            {
                parentblock.addChild(block: block)
            }
            else
            {
                screenBlock.addChild(block:block)
            }
        }
        else
        {
            screenBlock.addChild(block:block)
        }
    }
    
    
    func findBlock(nametofind:String,block:Block) -> Block?
    {
        for block in block.children
        {
            if block.name == nametofind
            {
                return block
            }
        }
        
        for block in block.children
        {
            if block.children.count > 0
            {
                return findBlock(nametofind: nametofind, block: block)
            }
        }
        
        return nil
    }
    
    func colorFromString(colorstr:String) -> NSColor
    {
        let p = colorstr.split(separator: ",", maxSplits: 4, omittingEmptySubsequences: false)
        
        let red = CGFloat(Double.init(p[0]) ?? 1.0)
        let green = CGFloat(Double.init(p[1]) ?? 1.0)
        let blue = CGFloat(Double.init(p[2]) ?? 1.0)
        let alpha = CGFloat(Double.init(p[3]) ?? 1.0)
        
        return NSColor.init(calibratedRed: red, green: green, blue: blue, alpha: alpha)
    }
 
    required init?(coder: NSCoder)
    {
        //
        // init
        //
        screenBlock = FLGrid(name:"Screen",view:nil)
        super.init(coder: coder)
        screenBlock.view = self
        
        
        screenBlock.x = 10
        screenBlock.y = 10
        screenBlock.width = 1000
        screenBlock.height = 700
        screenBlock.xspacing = 10
        screenBlock.yspacing = 10
        screenBlock.gridColor = NSColor.gray
        screenBlock.gradientAngle = -50
        screenBlock.clip = true
        screenBlock.fitToView = true
        screenBlock.fillGradient = NSGradient(starting: NSColor.init(calibratedRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.0), ending: NSColor.init(calibratedRed: 0.0, green: 0.4, blue: 0.0, alpha: 5.0))!
        screenBlock.windowChanged =
        {(block) -> Void in
            block.width = self.frame.width
            block.height = self.frame.height
        }
        
        
        
        let title = FLText(name:"title",view:self)
        title.text = "FilmLang"
        title.size = 40
        title.strokeColor = NSColor.init(calibratedRed: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
        title.fillGradient = NSGradient(starting: NSColor.black, ending: NSColor.init(calibratedRed: 0.0, green: 0.3, blue: 0.0, alpha: 0.5))!
        title.windowChanged =
        {(block) -> Void in
            block.x = self.frame.width / 2
           block.y = self.frame.height - 120
        }
        screenBlock.addChild(block: title)
        
        
        /*
        //
        // axis labels
        //
        let xaxislabel = FLText(name:"X Axis",view:self)
        xaxislabel.text = "X Axis"
        xaxislabel.x = screenBlock.width / 2
        xaxislabel.y = 10
        xaxislabel.size = 55
        xaxislabel.textColor = NSColor.init(calibratedRed: 0.0, green: 0.9, blue: 0.0, alpha: 1.0)
        xaxislabel.strokeColor = nil
        xaxislabel.animators.append(Animator(val: .x, amount: 1, min: 10, max:screenBlock.width, type: .Inc, windowChanged: {(animator) -> Void in animator?.max = self.frame.width }))
        
        let yaxislabel = FLText(name:"Y Axis",view:self)
        yaxislabel.text = "Y Axis"
        yaxislabel.x = 60
        yaxislabel.y = screenBlock.height / 2
        yaxislabel.size = 15
        yaxislabel.rotation = 90
        yaxislabel.textColor = NSColor.init(calibratedRed: 0.0, green: 0.9, blue: 0.0, alpha: 1.0)
        yaxislabel.strokeColor = NSColor.init(calibratedRed: 0.0, green: 0.9, blue: 0.0, alpha: 1.0)
        
        
        for bb in 1...4
        {
            let gridBlock1 = FLGrid(name:"Grid \(bb)",view:self)
            let r = FLRect(name:"R",view:self)
            r.fillColor = NSColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 0.6)
            r.strokeColor = NSColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 0.8)
            r.x = 10
            r.y = 10
            r.width = 40
            r.height = 30
            
            let r1 = FLRect(name:"R1",view:self)
            r1.fillColor = NSColor(red: 0.3, green: 0.2, blue: 0.4, alpha: 0.6)
            r1.strokeColor = NSColor(red: 0.3, green: 0.2, blue: 0.6, alpha: 0.8)
            r1.x = 400
            r1.y = 60
            r1.width = 20
            r1.height = 20
            
            let circle = FLCircle(name:"circle",view:self)
            circle.x = 100
            circle.y = 40
            circle.width = 30
            circle.height = 30
            circle.fillColor = NSColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 0.6)
            circle.strokeColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.8)
            circle.debug = true
            
            
            let path1 = FLPath(name:"Path",view:self)

            gridBlock1.x = 50
            gridBlock1.y = 110 * CGFloat(bb)
            gridBlock1.width = 400
            gridBlock1.height = 100
            gridBlock1.clip = true
            gridBlock1.fillGradient = NSGradient(starting: NSColor.black, ending: NSColor.init(calibratedRed: 0.0, green: 0.3, blue: 0.0, alpha: 0.5))!
            screenBlock.gradientAngle = 50
            
            gridBlock1.addChild(block:path1)
            gridBlock1.addChild(block:r);
            gridBlock1.addChild(block:r1);
            gridBlock1.addChild(block:circle)
            
            screenBlock.addChild(block:gridBlock1);
            
            circle.animators.append(Animator(val: .fillalpha, amount: 0.01, min: 0.1, max: 1.0, type: .Bounce, windowChanged:nil))
            circle.animators.append(Animator(val: .x, amount: 0.2, min: 100, max: 110.0, type: .Bounce, windowChanged:nil))
            
            r.animators.append(Animator(val: .fillalpha, amount: 0.01, min: 0.1, max: 1.0, type: .Bounce, windowChanged:nil))
            r.animators.append(Animator(val: .x, amount: 0.1, min: 10, max: 20.0, type: .Bounce, windowChanged:nil))
            
            r1.animators.append(Animator(val: .fillalpha, amount: 0.01, min: 0.1, max: 1.0, type: .Bounce, windowChanged:nil))
            r1.animators.append(Animator(val: .rotation, amount: 1.0, min: 0.0, max: 360, type: .Bounce, windowChanged:nil))
        }
        
        //yaxislabel.animators.append(Animator(val: "x", amount: 1.0, min: 90, max: 210.0, type: .Bounce))
        yaxislabel.animators.append(Animator(val: .rotation, amount: 1.0, min: 0.0, max: 90, type: .Bounce, windowChanged:nil))
        
        for i in 0...3
        {
            let arc1 = FLArc(name:"Arc \(i)",view:self)
            arc1.x = 700
            arc1.y = 400
            arc1.radius = 100
            arc1.strokeWidth = 10
            
            switch i {
            case 0:
                arc1.startAngle = 10
                arc1.endAngle = 90
                arc1.strokeColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.3)
                arc1.strokeWidth = 10
                arc1.radius = 100
                arc1.animators.append(Animator(val: .startangle, amount: 1, min: 10, max: 30, type: .Bounce, windowChanged:nil))
                arc1.animators.append(Animator(val: .endangle, amount: 2, min: 70, max: 90, type: .Bounce, windowChanged:nil))
                
            case 1:
                arc1.startAngle = 100
                arc1.endAngle = 180
                arc1.strokeColor = NSColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.3)
                arc1.strokeWidth = 10
                arc1.radius = 100
                arc1.animators.append(Animator(val:.startangle, amount: 1, min: 100, max: 120, type: .Bounce, windowChanged:nil))
                arc1.animators.append(Animator(val: .endangle, amount: 1, min: 130, max: 180, type: .Bounce, windowChanged:nil))
                
            case 2:
                arc1.startAngle = 100
                arc1.endAngle = 180
                arc1.strokeColor = NSColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.3)
                arc1.strokeWidth = 2
                arc1.animators.append(Animator(val: .startangle, amount: 1, min: 100, max: 120, type: .Bounce, windowChanged:nil))
                arc1.animators.append(Animator(val: .endangle, amount: 1, min: 130, max: 180, type: .Bounce, windowChanged:nil))
                arc1.radius = 90
                
            case 3:
                arc1.startAngle = 280
                arc1.endAngle = 355
                arc1.strokeColor = NSColor.orange
                arc1.strokeWidth = 1
                arc1.radius = 90
                arc1.animators.append(Animator(val: .radius, amount: 1, min: 90, max: 94, type: .Bounce, windowChanged:nil))
            default:
                arc1.startAngle = 10
                arc1.endAngle = 90
            }
           
            arc1.windowChanged =
            {(block) -> Void in
                block.x = self.frame.width - 200
                block.y = self.frame.height - 220
            }
            
            screenBlock.addChild(block: arc1)
        }
      
        screenBlock.addChild(block: title)
        screenBlock.addChild(block: xaxislabel)
        screenBlock.addChild(block: yaxislabel)
        */
        
        let js = Javascript(canvas: self)
        js.execScript()
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true)
        { (timer) in
            
            self.screenBlock.width = CGFloat(self.frame.width) - 20
            self.screenBlock.height = CGFloat(self.frame.height) - 20
            
            if self.screenBlock.animators.count > 0
            {
                self.screenBlock.animate()
            }
            
            self.animateChildren(children: self.screenBlock.children)
            
            self.needsDisplay = true
        }
        
    }
    
    
    func drawChildren(children:[Block])
    {
        for block in children
        {
            block.draw()
        }
    }
    
    func animateChildren(children:[Block])
    {
        for block in children
        {
            if block.animators.count > 0
            {
                block.animate()
            }
        }
        
        for block in children
        {
            if block.children.count > 0
            {
                animateChildren(children: block.children)
            }
        }
    }
    
    override func draw(_ dirtyRect: NSRect)
    {
        super.draw(dirtyRect)
       
        
        //
        // background
        //
        let backPath: NSBezierPath = NSBezierPath(rect: dirtyRect)
        let backColor = NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        backColor.setFill()
        backPath.fill()
        
        //
        // blocks
        //
        screenBlock.draw()
        
        
        /*
        //
        // settings
        //
        let width : Int = Int(dirtyRect.size.width)
        let height : Int = Int(dirtyRect.size.height)
        let padding : Int = 40
        let originx : Int = padding
        let originy : Int = padding
        let axiswidth : Int = 2
        
        
        //
        // axis
        //
        let axisColor = NSColor(red: 0.0, green: 0.8, blue: 0.0, alpha: 1.0)
        axisColor.setStroke()
        let axis = NSBezierPath()
        axis.lineWidth = CGFloat(axiswidth)
        axis.lineCapStyle = .square
        axis.move(to: NSPoint(x: originx, y: originy))
        axis.line(to: NSPoint(x: width - padding, y: originy))
        axis.move(to: NSPoint(x: originx, y: originy))
        axis.line(to: NSPoint(x: originx, y: height - padding))
        axis.stroke()
        
        
        //
        // ticks
        //
        let xticks = NSBezierPath()
        xticks.lineWidth = CGFloat(axiswidth)
        let inc = 20
        let ticklen = 5
        for x in stride(from: originx + inc, to: width - padding, by: inc)
        {
            xticks.move(to: NSPoint(x: x, y: originy - ticklen))
            xticks.line(to: NSPoint(x: x, y: originy + ticklen))
        }
        xticks.stroke()
        
        let yticks = NSBezierPath()
        yticks.lineWidth = CGFloat(axiswidth)
        for y in stride(from: originx + inc, to: height - padding, by: inc)
        {
            yticks.move(to: NSPoint(x: originx - ticklen, y: y))
            yticks.line(to: NSPoint(x: originx + ticklen, y: y))
        }
        yticks.stroke()
        */
        
       
        
        
    }
    
}
