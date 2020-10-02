//
//  FLAxis.swift
//  FilmLang
//
//  Created by Robert Dodson on 10/2/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class FLAxis : Block
{
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
    }
    
    
    override func draw()
    {
        preDraw()

        //
        // axis
        //
        strokeColor?.setStroke()
        let axis = NSBezierPath()
        axis.lineWidth = strokeWidth
        axis.lineCapStyle = .square
        axis.move(to: NSPoint(x: x + xoffset, y: y + yoffset))
        axis.line(to: NSPoint(x: x + width + xoffset, y: y + yoffset))
        axis.move(to: NSPoint(x: x + xoffset, y: y + yoffset))
        axis.line(to: NSPoint(x: x + xoffset, y: y + height + yoffset))
        axis.stroke()


        //
        // ticks
        //
        let xticks = NSBezierPath()
        xticks.lineWidth = strokeWidth
        let inc : CGFloat = 20
        let ticklen : CGFloat = 5
        for xtick in stride(from: x, to: x + width, by: inc)
        {
            xticks.move(to: NSPoint(x: xtick + xoffset, y: y - ticklen + yoffset))
            xticks.line(to: NSPoint(x: xtick + xoffset, y: y + ticklen + yoffset))
        }
        xticks.stroke()

        let yticks = NSBezierPath()
        yticks.lineWidth = strokeWidth
        for ytick in stride(from: y, to: y + height, by: inc)
        {
            yticks.move(to: NSPoint(x: x - ticklen + xoffset, y: ytick + yoffset))
            yticks.line(to: NSPoint(x: x + ticklen + xoffset, y: ytick + yoffset))
        }
        yticks.stroke()
            
        postDraw(rect: boundingRect)
    }
}
