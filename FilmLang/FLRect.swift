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
        
        if boundingRect != nil
        {
            let rectanglePath = NSBezierPath(roundedRect: boundingRect!, xRadius: radius, yRadius: radius)
        
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
                boundingRect!.clip()
            }
        }
        
        postDraw(rect: boundingRect)
        
    }
}
