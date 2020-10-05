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
    
    var xspacing : CGFloat = 10
    var yspacing : CGFloat = 10
    var gridColor = NSColor.green
    var gridStrokeWidth : CGFloat = 0.5
    
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let xspacing = dict["xspacing"]   as? CGFloat { self.xspacing = xspacing }
        if let yspacing = dict["yspacing"]   as? CGFloat { self.yspacing = yspacing }
        if let colordict = dict["gridColor"] as? NSDictionary  { self.gridColor = Block.colorFromDict(dict: colordict) }
        if let gridStrokeWidth = dict["gridStrokeWidth"]   as? CGFloat { self.gridStrokeWidth = gridStrokeWidth }
    }
    
    
    override func draw()
    {
        preDraw()
        
        if (fitToView)
        {
            width = (view?.frame.width)! - (viewPadding * 2)
            height = (view?.frame.height)! - (viewPadding * 2)
        }
        
        
        let rect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)
        let rectanglePath = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)


        if let fillgradient = fillGradient
        {
            fillgradient.draw(in: rectanglePath, angle: gradientAngle)
        }
        else if let fillcolor = fillColor
        {
            fillcolor.setFill()
            rectanglePath.fill()
        }
        
        
        let xaxiscount = Int(width / CGFloat(xspacing))
        for xx in 1...xaxiscount
        {
            let xpos = rect.origin.x + (xspacing * CGFloat(xx))
            
            let bezierPath = NSBezierPath()
            bezierPath.move(to: NSPoint(x: xpos, y: rect.origin.y))
            bezierPath.line(to: NSPoint(x: xpos, y: rect.origin.y + rect.height))
            
            gridColor.setStroke()
            bezierPath.lineWidth = gridStrokeWidth
            //bezierPath.setLineDash([2, 2], count: 2, phase: 0)
            bezierPath.stroke()
        }
        
        let yaxiscount = Int(height / CGFloat(yspacing))
        for yy in 1...yaxiscount
        {
            let ypos = rect.origin.y + (yspacing * CGFloat(yy))
            
            let bezierPath = NSBezierPath()
            bezierPath.move(to: NSPoint(x: rect.origin.x, y: ypos))
            bezierPath.line(to: NSPoint(x: rect.origin.x + rect.width, y: ypos))
            
            gridColor.setStroke()
            bezierPath.lineWidth = gridStrokeWidth
           // bezierPath.setLineDash([2, 2], count: 2, phase: 0)
            bezierPath.stroke()
        }
        
        
        if let strokecolor = strokeColor
        {
            strokecolor.setStroke()
            rectanglePath.lineWidth = strokeWidth
            rectanglePath.stroke()
        }
        
        postDraw(rect: rect)
    }
}
