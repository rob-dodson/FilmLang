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
        
        var xoffset : CGFloat
        var yoffset : CGFloat
        (xoffset,yoffset) = offset()
        
        let rect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)
        
        let ovalPath = NSBezierPath(ovalIn: rect)
        
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
        
        
        postDraw(rect:rect)
    }

}

