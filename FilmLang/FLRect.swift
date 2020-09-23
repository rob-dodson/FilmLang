//
//  FLRect.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/14/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class FLRect : Block
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
        let rectanglePath = NSBezierPath(roundedRect: rect, xRadius: raduis, yRadius: raduis)

        if rotation > -999
        {
            let context = NSGraphicsContext.current!.cgContext
            
            context.translateBy(x:rect.origin.x, y:rect.origin.y)
            context.rotate(by: CGFloat(rotation) * CGFloat.pi/180)
            context.translateBy(x:-rect.origin.x, y:-rect.origin.y)
        }
        
        if fillColor != nil
        {
            fillColor!.setFill()
            rectanglePath.fill()
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
