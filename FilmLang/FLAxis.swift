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
    var points : [NSPoint]
    var axisColor : NSColor
    
    override init(name:String, view:NSView?)
    {
        points = [NSPoint]()
        axisColor = NSColor.green
        
        super.init(name: name, view: view)
    }
    
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let colorDict = dict["axisColor"] as? NSDictionary { self.axisColor = Block.colorFromDict(dict: colorDict) }
        
        for i in 0...100
        {
            let key = "point\(i)"
            if let dict = dict[key]
            {
                self.points.append(Block.pointFromDict(dict:dict as! NSDictionary))
            }
        }
    }
    
    
    override func draw()
    {
        preDraw()

        //
        // axis
        //
        axisColor.setStroke()
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
            
        if points.count > 0
        {
            let path = NSBezierPath()
            path.lineJoinStyle = .round
            path.move(to: NSPoint(x: xoffset + x, y: yoffset + y))
            for point in points
            {
                path.line(to: NSPoint(x: point.x + xoffset + x, y: point.y + yoffset + y))
            }
            
            if strokeColor != nil
            {
                strokeColor!.setStroke()
                path.lineWidth = strokeWidth
                path.stroke()
            }
        }
        
        postDraw(rect: boundingRect)
    }
}
