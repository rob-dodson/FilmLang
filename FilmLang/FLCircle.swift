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
        
        let ovalPath = NSBezierPath(ovalIn: NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height))
        
        if fillColor != nil
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
        
        
        postDraw(rect:NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height))
    }

}

