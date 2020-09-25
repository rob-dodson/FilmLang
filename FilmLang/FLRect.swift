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
    override func draw()
    {
        preDraw()
        
        if (fitToView)
        {
            width = (view?.frame.width)! - 20
            height = (view?.frame.height)! - 20
        }
        
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
