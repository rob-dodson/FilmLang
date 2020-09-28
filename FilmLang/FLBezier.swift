//
//  FLBezier.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/28/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

struct BezPoint
{
    internal init(point: NSPoint, controlPoint1: NSPoint?, controlPoint2: NSPoint?)
    {
        self.point = point
        self.controlPoint1 = controlPoint1
        self.controlPoint2 = controlPoint2
    }
    
    let point : NSPoint
    let controlPoint1 : NSPoint?
    let controlPoint2 : NSPoint?
}

class FLBezier : Block
{
    var bezpoints : [BezPoint]
    
    override init(name:String, view:NSView?)
    {
        bezpoints = [BezPoint]()
        
        super.init(name: name, view: view)
    }
    
    
    override func draw()
    {
        preDraw()
        
        let path = NSBezierPath()
        
        let context = NSGraphicsContext.current!.cgContext
        context.translateBy(x:x + xoffset, y:y + yoffset)
        
        var count = 0
        for bezpoint in bezpoints
        {
            if bezpoint.controlPoint1 == nil && bezpoint.controlPoint2 == nil
            {
                if count == 0
                {
                    path.move(to: bezpoint.point)
                }
                else
                {
                    path.line(to: bezpoint.point)
                }
                count = count + 1
                
                if debug
                {
                    let box3 = NSRect(x: bezpoint.point.x, y: bezpoint.point.y, width: 5, height: 5)
                    NSColor.blue.setFill()
                    box3.fill()
                }
            }
            else
            {
                path.curve(to: bezpoint.point, controlPoint1: bezpoint.controlPoint1!, controlPoint2: bezpoint.controlPoint2!)
                
                if debug
                {
                    let box = NSRect(x: bezpoint.controlPoint1!.x, y: bezpoint.controlPoint1!.y, width: 5, height: 5)
                    NSColor.red.setFill()
                    box.fill()
                    let box2 = NSRect(x: bezpoint.controlPoint2!.x, y: bezpoint.controlPoint2!.y, width: 5, height: 5)
                    NSColor.green.setFill()
                    box2.fill()
                    let box3 = NSRect(x: bezpoint.point.x, y: bezpoint.point.y, width: 5, height: 5)
                    NSColor.orange.setFill()
                    box3.fill()
                }
            }
        }
        
        
        if strokeColor != nil
        {
            strokeColor!.setStroke()
            path.lineWidth = strokeWidth
            path.stroke()
        }
        
        context.translateBy(x:-(x + xoffset), y:-(y + yoffset))
        
        postDraw(rect: nil)
    }
}
       
