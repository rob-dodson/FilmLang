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
    var width : Double = 30.0
    var height : Double = 30.0
    var fill : Bool = false
    var strokeWidth : CGFloat = 1
    var fillColor : NSColor = NSColor.darkGray
    var strokeColor : NSColor = NSColor.gray
    var raduis : CGFloat = 2.0
    
    
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
        let rect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)
        let rectanglePath = NSBezierPath(roundedRect: rect, xRadius: raduis, yRadius: raduis)

        fillColor.setFill()
        rectanglePath.fill()
        strokeColor.setStroke()
        rectanglePath.lineWidth = strokeWidth
        rectanglePath.stroke()
        
        
        // for debugging
        let rectangleStyle = NSMutableParagraphStyle()
        rectangleStyle.alignment = .center
        let rectangleFontAttributes = [
            .font: NSFont(name: "HelveticaNeue", size: 12)!,
            .foregroundColor: NSColor.white,
            .paragraphStyle: rectangleStyle,
        ] as [NSAttributedString.Key: Any]
        name.draw(in: rect.offsetBy(dx: 0, dy: -4), withAttributes: rectangleFontAttributes)
    }
}
