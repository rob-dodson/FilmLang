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
    var endX               : CGFloat = 1.0
    var endY               : CGFloat = 1.0
    
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let endX = dict["endX"] as? CGFloat { self.endX = endX }
        if let endY = dict["endY"] as? CGFloat { self.endY = endY }
    }
    
    
    override func draw()
    {
        preDraw()
        
        let linePath = NSBezierPath()
        linePath.lineCapStyle = .square
        linePath.move(to: NSPoint(x: x, y: y))
        linePath.line(to: NSPoint(x: endX, y: endY))
        
            
        if let strokecolor = strokeColor
        {
            strokecolor.setStroke()
            linePath.lineWidth = strokeWidth
            linePath.stroke()
        }
            
        postDraw(rect: nil)
    }
}
