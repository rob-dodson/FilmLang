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

    
    required init?(coder: NSCoder)
    {
        screenBlock = FLGrid(name:"Screen")
        
        //
        // init
        //
        super.init(coder: coder)
        
        
        screenBlock.x = 10
        screenBlock.y = 10
        screenBlock.width = 1000
        screenBlock.height = 700
        screenBlock.xspacing = 10
        screenBlock.yspacing = 10
        screenBlock.gridColor = NSColor.gray
        screenBlock.fillGradient = NSGradient(starting: NSColor.init(calibratedRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.0), ending: NSColor.init(calibratedRed: 0.0, green: 0.4, blue: 0.0, alpha: 5.0))!
        
        let title = FLText(name:"title")
        title.text = "FilmLang Control Station"
        title.x = screenBlock.width / 2
        title.y = screenBlock.height - 100
        title.size = 40
        title.strokeColor = NSColor.init(calibratedRed: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
        title.fillGradient = NSGradient(starting: NSColor.black, ending: NSColor.init(calibratedRed: 0.0, green: 0.3, blue: 0.0, alpha: 0.5))!
        
        //
        // axis labels
        //
        let xaxislabel = FLText(name:"X Axis")
        xaxislabel.text = "X Axis"
        xaxislabel.x = screenBlock.width / 2
        xaxislabel.y = 10
        xaxislabel.size = 15
        xaxislabel.textColor = NSColor.init(calibratedRed: 0.0, green: 0.9, blue: 0.0, alpha: 1.0)
        xaxislabel.strokeColor = nil
        
        let yaxislabel = FLText(name:"Y Axis")
        yaxislabel.text = "Y Axis"
        yaxislabel.x = 60
        yaxislabel.y = screenBlock.height / 2
        yaxislabel.size = 15
        yaxislabel.rotation = 90
        yaxislabel.textColor = NSColor.init(calibratedRed: 0.0, green: 0.9, blue: 0.0, alpha: 1.0)
        yaxislabel.strokeColor = NSColor.init(calibratedRed: 0.0, green: 0.9, blue: 0.0, alpha: 1.0)
        
        for bb in 1...4
        {
            let gridBlock1 = FLGrid(name:"Grid \(bb)")
            let r = FLRect(name:"R")
            r.fillColor = NSColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 0.6)
            r.strokeColor = NSColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 0.8)
            r.x = 10
            r.y = 10
            r.width = 40
            r.height = 30
            
            let r1 = FLRect(name:"R1")
            r1.fillColor = NSColor(red: 0.3, green: 0.2, blue: 0.4, alpha: 0.6)
            r1.strokeColor = NSColor(red: 0.3, green: 0.2, blue: 0.6, alpha: 0.8)
            r1.x = 400
            r1.y = 60
            r1.width = 20
            r1.height = 20
            
            let circle = FLCircle(name:"circle")
            circle.x = 100
            circle.y = 40
            circle.width = 30
            circle.height = 30
            circle.fillColor = NSColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 0.6)
            circle.strokeColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.8)
            
            let path1 = FLPath(name:"Path")

            gridBlock1.x = 50
            gridBlock1.y = 110 * Double(bb)
            gridBlock1.width = 400
            gridBlock1.height = 100
            gridBlock1.clip = true
            gridBlock1.fillGradient = NSGradient(starting: NSColor.black, ending: NSColor.init(calibratedRed: 0.0, green: 0.3, blue: 0.0, alpha: 0.5))!
           
            
            gridBlock1.addChild(block:path1)
            gridBlock1.addChild(block:r);
            gridBlock1.addChild(block:r1);
            gridBlock1.addChild(block:circle)
            
            screenBlock.addChild(block:gridBlock1);
            
            circle.animators.append(Animator(name: "fillalpha", amount: 0.01, min: 0.1, max: 1.0, type: .Bounce))
            circle.animators.append(Animator(name: "x", amount: 0.2, min: 100, max: 110.0, type: .Bounce))
            
            r.animators.append(Animator(name: "fillalpha", amount: 0.01, min: 0.1, max: 1.0, type: .Bounce))
            r.animators.append(Animator(name: "x", amount: 0.1, min: 10, max: 20.0, type: .Bounce))
            
            r1.animators.append(Animator(name: "fillalpha", amount: 0.01, min: 0.1, max: 1.0, type: .Bounce))
           // r1.animators.append(Animator(name: "x", amount: 1.0, min: 90, max: 210.0, type: .Bounce))
            r1.animators.append(Animator(name: "rotation", amount: 1.0, min: 0.0, max: 360, type: .Bounce))
        }
        
        //yaxislabel.animators.append(Animator(name: "x", amount: 1.0, min: 90, max: 210.0, type: .Bounce))
        yaxislabel.animators.append(Animator(name: "rotation", amount: 1.0, min: 0.0, max: 90, type: .Bounce))
        
       screenBlock.addChild(block: title)
       screenBlock.addChild(block: xaxislabel)
       screenBlock.addChild(block: yaxislabel)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true)
        { (timer) in
            
            self.screenBlock.width = Double(self.frame.width) - 20
            self.screenBlock.height = Double(self.frame.height) - 20
            
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
        drawChildren(children: screenBlock.children)
        
        
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
