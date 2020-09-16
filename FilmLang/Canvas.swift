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
        
        
        screenBlock.x = 0
        screenBlock.y = 0
        screenBlock.width = 1000
        screenBlock.height = 1000
        screenBlock.xcount = 50
        screenBlock.ycount = 50
        screenBlock.fillGradient = NSGradient(starting: NSColor.init(calibratedRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.0), ending: NSColor.init(calibratedRed: 0.0, green: 0.4, blue: 0.0, alpha: 5.0))!
        
        let title = FLText(name:"title")
        title.text = "Vision"
        title.x = screenBlock.width / 2
        title.y = screenBlock.height - 40
        title.width = 50
        title.height = 50
        title.size = 90
        title.strokeColor = NSColor.init(calibratedRed: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
        
        
        
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
            r1.x = 100
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
            gridBlock1.fillGradient = NSGradient(starting: NSColor.black, ending: NSColor.init(calibratedRed: 0.0, green: 0.3, blue: 0.0, alpha: 0.5))!
           
            
            gridBlock1.addChild(block:path1)
            gridBlock1.addChild(block:r);
            gridBlock1.addChild(block:r1);
            gridBlock1.addChild(block:circle)
            
            screenBlock.addChild(block:gridBlock1);
            
            
            //let rr1 = Double(arc4random_uniform(100)) / 100
           // let rr2 = Double(arc4random_uniform(100))
            //gridBlock1.animators.append(Animator(name: "x", amount: rr1, min: rr2, max: 102.0, type: .Bounce))
            
            circle.animators.append(Animator(name: "fillalpha", amount: 0.01, min: 0.1, max: 1.0, type: .Bounce))
            circle.animators.append(Animator(name: "x", amount: 0.2, min: 100, max: 110.0, type: .Bounce))
            
            r.animators.append(Animator(name: "fillalpha", amount: 0.01, min: 0.1, max: 1.0, type: .Bounce))
            r.animators.append(Animator(name: "x", amount: 0.1, min: 10, max: 20.0, type: .Bounce))
            
            r1.animators.append(Animator(name: "fillalpha", amount: 0.01, min: 0.1, max: 1.0, type: .Bounce))
            r1.animators.append(Animator(name: "x", amount: 1.0, min: 90, max: 210.0, type: .Bounce))
        }
        
        screenBlock.addChild(block: title)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true)
        { (timer) in
            
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
            
            if block.children.count > 0
            {
                drawChildren(children: block.children)
            }
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
       
        
        NSGraphicsContext.saveGraphicsState()
        
        //
        // background
        //
        let backPath: NSBezierPath = NSBezierPath(rect: dirtyRect)
        let backColor = NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        backColor.setFill()
        backPath.fill()
        
        
        
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
        
        
        //
        // blocks
        //
        screenBlock.draw()
        drawChildren(children: screenBlock.children)
        
        
        //
        // labels
        //
        NSGraphicsContext.saveGraphicsState()
        
        let textRect = NSRect(x: width / 2, y: originy - 28, width: 75, height: 16)
        let textTextContent = "X Axis"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes = [
            .font: NSFont.systemFont(ofSize: NSFont.systemFontSize),
            .foregroundColor: NSColor.systemPurple,
            .paragraphStyle: textStyle,
        ] as [NSAttributedString.Key: Any]

        let textTextHeight: CGFloat = textTextContent.boundingRect(with: NSSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes).height
        let textTextRect: NSRect = NSRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight)
        textRect.clip()
        textTextContent.draw(in: textTextRect.offsetBy(dx: 0, dy: 0.5), withAttributes: textFontAttributes)
       NSGraphicsContext.restoreGraphicsState()

        NSGraphicsContext.saveGraphicsState()
        let textRecty = NSRect(x: 0, y: 0, width: 75, height: 16)
        let context = NSGraphicsContext.current!.cgContext
        context.translateBy(x: CGFloat(originx) - (CGFloat(padding) / 2.0), y: (CGFloat(height) / 2.0) - (textRecty.width / 2))
        context.rotate(by: 90 * CGFloat.pi/180)
        
        let textTextContenty = "Y Axis"
        let textStyley = NSMutableParagraphStyle()
        textStyley.alignment = .center
        let textFontAttributesy = [
            .font: NSFont.systemFont(ofSize: NSFont.systemFontSize),
            .foregroundColor: NSColor.systemPurple,
            .paragraphStyle: textStyley,
        ] as [NSAttributedString.Key: Any]

        let textTextHeighty: CGFloat = textTextContent.boundingRect(with: NSSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributesy).height
        let textTextRecty: NSRect = NSRect(x: textRecty.minX, y: textRecty.minY + (textRecty.height - textTextHeighty) / 2, width: textRect.width, height: textTextHeighty)
        textRecty.clip()
        textTextContenty.draw(in: textTextRecty.offsetBy(dx: 0, dy: 0.5), withAttributes: textFontAttributes)
         
        NSGraphicsContext.restoreGraphicsState()
        
        
    }
    
}
