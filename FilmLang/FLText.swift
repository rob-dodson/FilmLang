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
        preDraw()
        
        let pad : CGFloat = 5.0
        var ox : Double
        var oy : Double
        (ox,oy) = offset()
        
        let label = "\(text) - \(Int(rotation))"
        
       
      
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .left
        let textFontAttributes = [
            .font: NSFont(name: "Futura", size: size)!,
            .foregroundColor: textColor,
            .paragraphStyle: textStyle,
        ] as [NSAttributedString.Key: Any]

        
        let boundingRect = label.boundingRect(with: NSSize(width: CGFloat.infinity,
                                                          height: CGFloat.infinity),
                                             options: .usesLineFragmentOrigin,
                                             attributes: textFontAttributes)
        
      
        
        let textRect: NSRect = NSRect(x: CGFloat(x + ox) - pad - (boundingRect.width / 2),
                                          y: CGFloat(y + oy) + (boundingRect.height / 2) - pad,
                                          width: boundingRect.width + (pad * 2),
                                          height: boundingRect.height + (pad * 2))

        
             
        if rotation > -999
        {
            let context = NSGraphicsContext.current!.cgContext
            
            context.translateBy(x:textRect.origin.x, y:textRect.origin.y)
            context.rotate(by: CGFloat(rotation) * CGFloat.pi/180)
            context.translateBy(x:-textRect.origin.x, y:-textRect.origin.y)
        }
        
        
        let borderPath = NSBezierPath(roundedRect: textRect, xRadius: raduis, yRadius: raduis)
        if strokeColor != nil
        {
            strokeColor!.setStroke()
            borderPath.lineWidth = strokeWidth
            borderPath.stroke()
        }
        
        if fillGradient != nil
        {
            fillGradient!.draw(in: borderPath, angle: gradientAngle)
        }
        else if fillColor != nil
        {
            fillColor!.setFill()
            borderPath.fill()
        }
        
        label.draw(in: textRect.offsetBy(dx: 0 + pad, dy: 0.0 - pad), withAttributes: textFontAttributes)

        
        postDraw(rect:nil)
    }
}
