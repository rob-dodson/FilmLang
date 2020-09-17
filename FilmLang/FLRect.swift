//
//  FLRect.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/14/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class FLRect : Block
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
        let rect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)
        let rectanglePath = NSBezierPath(roundedRect: rect, xRadius: raduis, yRadius: raduis)

        if fillColor != nil
        {
            fillColor!.setFill()
            rectanglePath.fill()
        }
        
        if strokeColor != nil
        {
            strokeColor!.setStroke()
            rectanglePath.lineWidth = strokeWidth
            rectanglePath.stroke()
        }
        
        
        // for debugging
        let rectangleStyle = NSMutableParagraphStyle()
        rectangleStyle.alignment = .center
        let rectangleFontAttributes = [
            .font: NSFont(name: "Futura", size: 12)!,
            .foregroundColor: NSColor.white,
            .paragraphStyle: rectangleStyle,
        ] as [NSAttributedString.Key: Any]
        name.draw(in: rect.offsetBy(dx: 0, dy: -4), withAttributes: rectangleFontAttributes)
    }
}
