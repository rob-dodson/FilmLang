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
    
    var startAngle : CGFloat = 0
    var endAngle : CGFloat = 45
    
    
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
        
        let startPoint = NSPoint(x: x + xoffset, y: y - yoffset)
        let arcPath = NSBezierPath()
        arcPath.appendArc(withCenter: startPoint, radius: CGFloat(radius),
                          startAngle: startAngle, endAngle: endAngle)
        
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
        
        
        postDraw(rect:rect)
    }

}

