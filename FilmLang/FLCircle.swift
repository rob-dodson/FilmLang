//
//  FLCircle.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/14/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

class FLCircle : Block
{
    var width : Double = 30
    var height : Double = 30
    var fill : Bool = false
    var strokeWidth : CGFloat = 2
    var fillColor : NSColor = NSColor.darkGray
    var strokeColor : NSColor = NSColor.green

    
    override func animate()
    {
        for var animator in animators
        {
            if animator.name == "x"
            {
                adjust(obj:&self.x, animator: &animator)
            }
            else if animator.name == "fillalpha"
            {
                if fillColor.alphaComponent <= 0.0 { fillColor = fillColor.withAlphaComponent(1.0) }
                fillColor = fillColor.withAlphaComponent(fillColor.alphaComponent - 0.01)
            }
        }
    }
    
    override func draw()
    {
        var xoffset : Double
        var yoffset : Double
        (xoffset,yoffset) = offset()
        
        let ovalPath = NSBezierPath(ovalIn: NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height))
        fillColor.setFill()
        ovalPath.fill()
        strokeColor.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()
    }

}

