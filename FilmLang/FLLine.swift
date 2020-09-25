//
//  FLLine.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/25/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class FLLine : Block
{
  
    
    override func draw()
    {
        preDraw()
        
        let linePath = NSBezierPath()
        linePath.move(to: NSPoint(x: x, y: y))
        linePath.line(to: NSPoint(x: endX, y: endY))
        
            
        if strokeColor != nil
        {
            strokeColor!.setStroke()
            linePath.lineWidth = strokeWidth
            linePath.stroke()
        }
            
        postDraw(rect: nil)
        
    }
}
