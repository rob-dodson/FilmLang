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
    var objects : [Block]?
    let topBlock : FLGrid
    
    required init?(coder: NSCoder)
    {
        topBlock = FLGrid(name:"Top",parent:nil)
        
        let r = FLRect(name:"R",parent:nil)
        r.fillColor = NSColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 0.6)
        r.strokeColor = NSColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 0.8)
        
        let r1 = FLRect(name:"R1",parent:nil)
        r1.fillColor = NSColor(red: 0.3, green: 0.2, blue: 0.4, alpha: 0.6)
        r1.strokeColor = NSColor(red: 0.3, green: 0.2, blue: 0.6, alpha: 0.8)
        
        super.init(coder: coder)

        
        topBlock.x = 100
        topBlock.y = 100
        topBlock.width = 200
        topBlock.height = 200
        topBlock.addChild(block:r);
        topBlock.addChild(block:r1);
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true)
        { (timer) in
            
            self.topBlock.animateBlock!(self.topBlock)
            
            for object in self.topBlock.children
            {
                if object.animateBlock != nil
                {
                    object.animateBlock!(object)
                }
            }
            
            self.needsDisplay = true
        }
        
        
        topBlock.animateBlock =
        { (obj:Block) in
            let rect : FLGrid = obj as! FLGrid
            rect.x = rect.x + 0.2
            rect.y = rect.y + 0.3
            
            if rect.x > 200.0 { rect.x = 40.0 }
            if rect.y > 200.0 { rect.y = 40.0 }
            
            rect.fillColor = rect.fillColor.withAlphaComponent(0.5)
        }
        
        
        r.animateBlock =
        { (obj:Block) in
            let rect : FLRect = obj as! FLRect
            rect.x = rect.x + 0.2
            rect.y = rect.y + 0.3
            
            if rect.x > 200.0 { rect.x = 40.0 }
            if rect.y > 200.0 { rect.y = 40.0 }
            
            if rect.fillColor.alphaComponent <= 0.0 { rect.fillColor = rect.fillColor.withAlphaComponent(1.0) }
            rect.fillColor = rect.fillColor.withAlphaComponent(rect.fillColor.alphaComponent - 0.01)
        }
    
        r1.animateBlock =
        { (obj:Block) in
            let rect : FLRect = obj as! FLRect
            
            if rect.fillColor.alphaComponent <= 0.0 { rect.fillColor = rect.fillColor.withAlphaComponent(1.0) }
            rect.fillColor = rect.fillColor.withAlphaComponent(rect.fillColor.alphaComponent - 0.01)
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
        topBlock.draw()
        for block in topBlock.children
        {
            block.draw()
        }
        
        
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
        
        
        //
        // data
        //
        let bezierPath = NSBezierPath()
        
        let ox : Double = Double(originx)
        let oy : Double = Double(originy)
        
        bezierPath.move(to: NSPoint(x: ox + 17.5, y: oy + 27.5))
        bezierPath.curve(to: NSPoint(x: ox + 85.5, y: oy + 63.5),  controlPoint1: NSPoint(x: ox + 70.5, y: oy + 66.5),  controlPoint2: NSPoint(x: ox + 52.5, y: oy + 81.5))
        bezierPath.curve(to: NSPoint(x: ox + 162.5, y: oy + 34.5), controlPoint1: NSPoint(x: ox + 118.5, y: oy + 45.5), controlPoint2: NSPoint(x: ox + 123.5, y: oy + -1.5))
        bezierPath.curve(to: NSPoint(x: ox + 225.5, y: oy + 71.5), controlPoint1: NSPoint(x: ox + 201.5, y: oy + 70.5), controlPoint2: NSPoint(x: ox + 217.5, y: oy + 88.5))
        NSColor.red.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
}
