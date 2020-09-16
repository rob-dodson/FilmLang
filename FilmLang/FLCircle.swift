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
    var strokeColor : NSColor = NSColor.green

    
    override func animate()
    {
        super.animate()
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

