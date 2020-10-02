//
//  FLArc.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/21/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//
import Foundation
import Cocoa

class FLArc : Block
{
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let startAngle = dict["startAngle"] as? CGFloat { self.startAngle = startAngle }
        if let endAngle = dict["endAngle"]     as? CGFloat { self.endAngle = endAngle }
    }
    
    
    override func draw()
    {
        preDraw()
        
        let startPoint = NSPoint(x: x + xoffset, y: y + yoffset)
        let arcPath = NSBezierPath()
        arcPath.appendArc(withCenter: startPoint, radius: CGFloat(radius),
                          startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle))
        
        if fillColor != nil
        {
            fillColor!.setFill()
            arcPath.fill()
        }
        
        if strokeColor != nil
        {
            strokeColor!.setStroke()
            arcPath.lineWidth = strokeWidth
            arcPath.stroke()
        }
        
        postDraw(rect:NSRect(x: arcPath.bounds.origin.x,y: arcPath.bounds.origin.y,width: arcPath.bounds.width,height: arcPath.bounds.height))
    }

}

