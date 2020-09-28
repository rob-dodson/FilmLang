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
        
        for bezpoint in bezpoints
        {
            if bezpoint.controlPoint1 == nil && bezpoint.controlPoint2 == nil
            {
                path.move(to: bezpoint.point)
            }
            else
            {
                path.curve(to: bezpoint.point, controlPoint1: bezpoint.controlPoint1!, controlPoint2: bezpoint.controlPoint2!)
            }
        }
        
        let context = NSGraphicsContext.current!.cgContext
        context.translateBy(x:x + xoffset, y:y + yoffset)
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
       
