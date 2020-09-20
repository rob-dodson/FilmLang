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
    
    var xspacing = 10
    var yspacing = 10
    var gridColor = NSColor.green
    var gridStrokeWidth : CGFloat = 0.5
    
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
        
        
        let xaxiscount = Int(width / Double(xspacing))
        for xx in 1...xaxiscount
        {
            let xpos = rect.origin.x + CGFloat(xspacing * xx)
            
            let bezierPath = NSBezierPath()
            bezierPath.move(to: NSPoint(x: xpos, y: rect.origin.y))
            bezierPath.line(to: NSPoint(x: xpos, y: rect.origin.y + rect.height))
            
            gridColor.setStroke()
            bezierPath.lineWidth = gridStrokeWidth
            bezierPath.setLineDash([2, 2], count: 2, phase: 0)
            bezierPath.stroke()
        }
        
        let yaxiscount = Int(height / Double(yspacing))
        for yy in 1...yaxiscount
        {
            let ypos = rect.origin.y + CGFloat(yspacing * yy)
            
            let bezierPath = NSBezierPath()
            bezierPath.move(to: NSPoint(x: rect.origin.x, y: ypos))
            bezierPath.line(to: NSPoint(x: rect.origin.x + rect.width, y: ypos))
            
            gridColor.setStroke()
            bezierPath.lineWidth = gridStrokeWidth
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
