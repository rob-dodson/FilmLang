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
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
    }
    
    
    override func draw()
    {
        preDraw()
        
        if (fitToView)
        {
            width = (Block.view?.frame.width)! - (viewPadding * 2)
            height = (Block.view?.frame.height)! - (viewPadding * 2)
        }
        
        if boundingRect != nil
        {
            let rectanglePath = NSBezierPath(roundedRect: boundingRect!, xRadius: radius, yRadius: radius)
        
            if let fillgradient = fillGradient
            {
                fillgradient.draw(in: rectanglePath, angle: gradientAngle)
            }
            else if let fillcolor = fillColor
            {
                fillcolor.setFill()
                rectanglePath.fill()
            }
            
            if let strokecolor = strokeColor
            {
                strokecolor.setStroke()
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
