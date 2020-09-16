//
//  FLPath.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/14/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

class FLPath : Block
{
    override func draw()
    {
        var ox : Double
        var oy : Double
        (ox,oy) = offset()

        let bezierPath = NSBezierPath()

        let rr1 = Double(arc4random_uniform(25))
        let rr2 = Double(arc4random_uniform(25)) + 380
        let rr3 = Double(arc4random_uniform(25)) + 162
        
        bezierPath.move(to: NSPoint(x: ox + rr1, y: oy + 27.5))
        bezierPath.curve(to: NSPoint(x: ox + 85.5, y: oy + 63.5),  controlPoint1: NSPoint(x: ox + 70.5, y: oy + 66.5),  controlPoint2: NSPoint(x: ox + 52.5, y: oy + 81.5))
        bezierPath.curve(to: NSPoint(x: ox + rr3, y: oy + 34.5), controlPoint1: NSPoint(x: ox + 118.5, y: oy + 45.5), controlPoint2: NSPoint(x: ox + 123.5, y: oy + -1.5))
        bezierPath.curve(to: NSPoint(x: ox + rr2, y: oy + 71.5), controlPoint1: NSPoint(x: ox + 200, y: oy + 70.5), controlPoint2: NSPoint(x: ox + 217.5, y: oy + 88.5))
        
        
        strokeColor.setStroke()
        bezierPath.lineWidth = CGFloat(arc4random_uniform(4)) //strokeWidth
        bezierPath.stroke()
        
        
    }
}
       
