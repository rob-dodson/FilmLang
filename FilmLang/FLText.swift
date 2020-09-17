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
    var textColor = NSColor.green
    
    override func animate()
    {
        super.animate()
    }
    
    override func draw()
    {
        var ox : Double
        var oy : Double
        (ox,oy) = offset()
        
        let label = "\(text) - \(rotation)"
        
        let context = NSGraphicsContext.current!.cgContext
        let pad : CGFloat = 5.0
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .left
        let textFontAttributes = [
            .font: NSFont(name: "Futura", size: size)!,
            .foregroundColor: textColor,
            .paragraphStyle: textStyle,
        ] as [NSAttributedString.Key: Any]

        NSGraphicsContext.saveGraphicsState()
        
        if rotation != 0.0
        {
            context.translateBy(x: 0 - CGFloat(x + ox), y:0 - CGFloat(y + oy))
            context.rotate(by: CGFloat(rotation) * CGFloat.pi/180)
        }
        
        
        let boundingRect = label.boundingRect(with: NSSize(width: CGFloat.infinity,
                                                          height: CGFloat.infinity),
                                             options: .usesLineFragmentOrigin,
                                             attributes: textFontAttributes)
        
        let textTextRect: NSRect = NSRect(x: CGFloat(x + ox) - pad - (boundingRect.width / 2), // center on X 
                                          y: CGFloat(y + oy) + (boundingRect.height / 2) - pad,
                                          width: boundingRect.width + (pad * 2),
                                          height: boundingRect.height + (pad * 2))

        
        let rectanglePath = NSBezierPath(roundedRect: textTextRect, xRadius: raduis, yRadius: raduis)
        
        
        if strokeColor != nil
        {
            strokeColor!.setStroke()
            rectanglePath.lineWidth = strokeWidth
            rectanglePath.stroke()
        }
        
        if fillGradient != nil
        {
            fillGradient?.draw(in: rectanglePath, angle: -90)
        }
        else if fillColor != nil
        {
            fillColor!.setFill()
            rectanglePath.fill()
        }
        
        label.draw(in: textTextRect.offsetBy(dx: 0 + pad, dy: 0.0 - pad), withAttributes: textFontAttributes)
        
        NSGraphicsContext.restoreGraphicsState()
    }
}
