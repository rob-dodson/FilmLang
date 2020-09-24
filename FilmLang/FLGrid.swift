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
    var fitToView : Bool = false
    
    
    override func animate()
    {
        super.animate()
    }
    
    
    override func draw()
    {
        preDraw()
        
        var xoffset : CGFloat
        var yoffset : CGFloat
        (xoffset,yoffset) = offset()
        
        if (fitToView)
        {
            width = (view?.frame.width)! - 20
            height = (view?.frame.height)! - 20
        }
        
        
        let rect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)
        let rectanglePath = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)


        if fillGradient != nil
        {
            fillGradient?.draw(in: rectanglePath, angle: gradientAngle)
        }
        else if fillColor != nil
        {
            fillColor!.setFill()
            rectanglePath.fill()
        }
        
        
        let xaxiscount = Int(width / CGFloat(xspacing))
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
        
        let yaxiscount = Int(height / CGFloat(yspacing))
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
