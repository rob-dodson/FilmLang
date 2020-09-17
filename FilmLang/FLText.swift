//
//  FLText.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/16/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

class FLText : Block
{
    var text : String = "???"
    var size : CGFloat = 24.0
    
    override func animate()
    {
        super.animate()
    }
    
    override func draw()
    {
        var ox : Double
        var oy : Double
        (ox,oy) = offset()
        
        //// Text Drawing
        let textRect = NSRect(x: x + ox, y: y + oy, width: width, height: height)
        
        // debug
        let rectanglePath = NSBezierPath(roundedRect: textRect, xRadius: raduis, yRadius: raduis)
        strokeColor.setStroke()
        rectanglePath.lineWidth = 2
        rectanglePath.stroke()
        
        
        let textTextContent = "Hello, World!"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .left
        let textFontAttributes = [
            .font: NSFont.systemFont(ofSize: size),
            .foregroundColor: strokeColor,
            .paragraphStyle: textStyle,
        ] as [NSAttributedString.Key: Any]

        let textTextHeight: CGFloat = textTextContent.boundingRect(with: NSSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes).height
        let textTextRect: NSRect = NSRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight)
        
        // debug
        let rectanglePath2 = NSBezierPath(roundedRect: textTextRect, xRadius: raduis, yRadius: raduis)
        NSColor.red.setStroke()
        rectanglePath2.lineWidth = 2
        rectanglePath2.stroke()
        
        
        NSGraphicsContext.saveGraphicsState()
        textRect.clip()
        text.draw(in: textTextRect.offsetBy(dx: 0, dy: 0.5), withAttributes: textFontAttributes)
        
        NSGraphicsContext.restoreGraphicsState()
    }
}
