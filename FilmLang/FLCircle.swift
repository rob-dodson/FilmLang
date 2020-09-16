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
        
        // for debugging
        let rectangleStyle = NSMutableParagraphStyle()
        rectangleStyle.alignment = .center
        let rectangleFontAttributes = [
            .font: NSFont(name: "Futura", size: 12)!,
            .foregroundColor: NSColor.white,
            .paragraphStyle: rectangleStyle,
        ] as [NSAttributedString.Key: Any]
        name.draw(in: ovalPath.bounds.offsetBy(dx: 0, dy: -4), withAttributes: rectangleFontAttributes)
        
    }

}

