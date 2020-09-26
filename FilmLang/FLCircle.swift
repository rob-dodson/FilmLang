//
//  FLCircle.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/14/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

class FLCircle : Block
{
    
    override func draw()
    {
        preDraw()
        
        var rect : NSRect?
        if radius > 0.0
        {
            rect = NSRect(x: (x + xoffset) - radius, y: (y + yoffset) - radius, width: radius * 2, height: radius * 2)
        }
        else
        {
            rect = NSRect(x: x + xoffset - (width / 2), y: y + yoffset - (height / 2), width:width, height: width)
        }
        
        let ovalPath = NSBezierPath(ovalIn: rect!)
        
        if fillGradient != nil
        {
            fillGradient!.draw(in: ovalPath, angle: gradientAngle)
        }
        else if fillColor != nil
        {
            fillColor!.setFill()
            ovalPath.fill()
        }
        
        if strokeColor != nil
        {
            strokeColor!.setStroke()
            ovalPath.lineWidth = 1
            ovalPath.stroke()
        }
        
        postDraw(rect:rect)
    }

}

