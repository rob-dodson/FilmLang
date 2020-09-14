//
//  BlockProtocol.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/13/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class Block
{
    var parent : Block?
    var children : [Block]
    var name: String
    var animateBlock: ((_ obj:Block) -> Void)?
    var x : Double = 10.0
    var y : Double = 10.0
    
    init(name:String,parent:Block?)
    {
        self.name = name
        self.parent = parent
        self.children = [Block]()
    }
    
    func addChild(block:Block)
    {
        children.append(block);
        block.parent = self;
    }
    
    
    func offset() -> (Double,Double)
    {
        var x : Double = 0
        var y : Double = 0
        
        var p = parent
        while p != nil
        {
            x = x + p!.x
            y = y + p!.y
            p = p?.parent
        }
        return (x,y)
    }
    
    func draw()
    {
    }
    
}


class FLGrid : Block
{
    var width : Double = 111.0
    var height : Double = 111.0
    var fill : Bool = false
    var strokeWidth : CGFloat = 2
    var fillColor : NSColor = NSColor.darkGray
    var strokeColor : NSColor = NSColor.green
    var raduis : CGFloat = 1.0
    var ycount = 10
    var xcount = 10
    
    
    override func draw()
    {
        var xoffset : Double
        var yoffset : Double
        (xoffset,yoffset) = offset()
        
        let rect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)
        let rectanglePath = NSBezierPath(roundedRect: rect, xRadius: raduis, yRadius: raduis)


        let gradient = NSGradient(starting: NSColor.black, ending: NSColor.init(calibratedRed: 0.0, green: 0.5, blue: 0.0, alpha: 1.0))!

        
        fillColor.setFill()
        //rectanglePath.fill()
        gradient.draw(in: rectanglePath, angle: -90)
        
        for yy in 1...ycount - 1
        {
            let bezierPath = NSBezierPath()
            let y = CGFloat((Int(width) / ycount) * yy)
            
            bezierPath.move(to: NSPoint(x: rect.origin.x, y: rect.origin.y + y))
            bezierPath.line(to: NSPoint(x: rect.origin.x + rect.width, y: rect.origin.y + y))
            
            NSColor.green.setStroke()
            bezierPath.lineWidth = 0.5
            bezierPath.setLineDash([2, 2], count: 2, phase: 0)
            bezierPath.stroke()
        }
        
        for xx in 1...xcount - 1
        {
            let bezierPath = NSBezierPath()
            let x = CGFloat((Int(height) / xcount) * xx)
            
            bezierPath.move(to: NSPoint(x: rect.origin.x + x, y: rect.origin.y))
            bezierPath.line(to: NSPoint(x: rect.origin.x + x, y: rect.origin.y + rect.height))
            
            NSColor.green.setStroke()
            bezierPath.lineWidth = 0.5
            bezierPath.setLineDash([2, 2], count: 2, phase: 0)
            bezierPath.stroke()
        }
        
        strokeColor.setStroke()
        rectanglePath.lineWidth = strokeWidth
        rectanglePath.stroke()
        
    }
}


class FLRect : Block
{
    var width : Double = 30.0
    var height : Double = 30.0
    var fill : Bool = false
    var strokeWidth : CGFloat = 1
    var fillColor : NSColor = NSColor.darkGray
    var strokeColor : NSColor = NSColor.gray
    var raduis : CGFloat = 2.0
    
    override func draw()
    {
        var xoffset : Double
        var yoffset : Double
        (xoffset,yoffset) = offset()
        let rect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)
        let rectanglePath = NSBezierPath(roundedRect: rect, xRadius: raduis, yRadius: raduis)

        fillColor.setFill()
        rectanglePath.fill()
        strokeColor.setStroke()
        rectanglePath.lineWidth = strokeWidth
        rectanglePath.stroke()
        
        
        // for debugging
        let rectangleStyle = NSMutableParagraphStyle()
        rectangleStyle.alignment = .center
        let rectangleFontAttributes = [
            .font: NSFont(name: "HelveticaNeue", size: 12)!,
            .foregroundColor: NSColor.white,
            .paragraphStyle: rectangleStyle,
        ] as [NSAttributedString.Key: Any]
        name.draw(in: rect.offsetBy(dx: 0, dy: -4), withAttributes: rectangleFontAttributes)
    }
    
}
