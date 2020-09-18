//
//  FLGrid.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/14/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class FLGrid : Block
{
    
    var ycount = 10
    var xcount = 10
    

    
    override func animate()
    {
        super.animate()
    }
    
    
    override func draw()
    {
        preDraw()
        
        
        var xoffset : Double
        var yoffset : Double
        (xoffset,yoffset) = offset()
        
        let rect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)
        let rectanglePath = NSBezierPath(roundedRect: rect, xRadius: raduis, yRadius: raduis)


        if fillGradient != nil
        {
            fillGradient?.draw(in: rectanglePath, angle: -90)
        }
        else if fillColor != nil
        {
            fillColor!.setFill()
            rectanglePath.fill()
        }
        
        for yy in 1...ycount - 1
        {
            let bezierPath = NSBezierPath()
            let y = CGFloat((Int(height) / ycount) * yy)
            
            bezierPath.move(to: NSPoint(x: rect.origin.x, y: rect.origin.y + y))
            bezierPath.line(to: NSPoint(x: rect.origin.x + rect.width, y: rect.origin.y + y))
            
            NSColor.green.setStroke()
            bezierPath.lineWidth = 0.5
            bezierPath.setLineDash([1, 2, 1 , 4], count: 4, phase: 0)
            bezierPath.stroke()
        }
        
        for xx in 1...xcount - 1
        {
            let bezierPath = NSBezierPath()
            let x = CGFloat((Int(width) / xcount) * xx)
            
            bezierPath.move(to: NSPoint(x: rect.origin.x + x, y: rect.origin.y))
            bezierPath.line(to: NSPoint(x: rect.origin.x + x, y: rect.origin.y + rect.height))
            
            NSColor.green.setStroke()
            bezierPath.lineWidth = 0.5
            bezierPath.setLineDash([2, 2], count: 2, phase: 0)
            bezierPath.stroke()
        }
        
        if strokeColor != nil
        {
            strokeColor!.setStroke()
            rectanglePath.lineWidth = strokeWidth
            rectanglePath.stroke()
        }
        
        if clip == true
        {
            rect.clip()
        }
        
        postDraw(rect: rect)
    }
}
