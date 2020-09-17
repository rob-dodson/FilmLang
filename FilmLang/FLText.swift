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
        
        let pad : CGFloat = 5.0
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .left
        let textFontAttributes = [
            .font: NSFont(name: "Futura", size: size)!,
            .foregroundColor: strokeColor,
            .paragraphStyle: textStyle,
        ] as [NSAttributedString.Key: Any]

        
        let boundingRect = text.boundingRect(with: NSSize(width: CGFloat.infinity,
                                                          height: CGFloat.infinity),
                                             options: .usesLineFragmentOrigin,
                                             attributes: textFontAttributes)
        
        let textTextRect: NSRect = NSRect(x: CGFloat(x + ox) - pad,
                                          y: CGFloat(y + oy) + (boundingRect.height / 2) - pad,
                                          width: boundingRect.width + (pad * 2),
                                          height: boundingRect.height + (pad * 2))

        let rectanglePath = NSBezierPath(roundedRect: textTextRect, xRadius: raduis, yRadius: raduis)
        strokeColor.setStroke()
        rectanglePath.lineWidth = 2
        rectanglePath.stroke()
        if fillGradient != nil
        {
            fillGradient?.draw(in: rectanglePath, angle: -90)
        }
        else
        {
            fillColor.setFill()
            rectanglePath.fill()
        }
        
        text.draw(in: textTextRect.offsetBy(dx: 0 + pad, dy: 0.0 - pad), withAttributes: textFontAttributes)
    }
}
