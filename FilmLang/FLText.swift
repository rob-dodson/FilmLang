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
    var font : String = "Helvetica"
    var size : CGFloat = 24.0
    var textColor = NSColor.green
    var padding : CGFloat = 0.0
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        strokeColor = nil
        
        if let textstr = dict["text"]        as? String { text = textstr }
        if let fontstr = dict["font"]        as? String { font = fontstr }
        if let colordict = dict["textColor"] as? NSDictionary  { textColor = Block.colorFromDict(dict: colordict) }
        if let size = dict["size"]           as? CGFloat { self.size = size }
        if let padding = dict["padding"]     as? CGFloat { self.padding = padding }
    }
    
    
    override func draw()
    {
        preDraw()
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .left
        let textFontAttributes = [
            .font: NSFont(name: font, size: size)!,
            .foregroundColor: textColor,
            .paragraphStyle: textStyle,
        ] as [NSAttributedString.Key: Any]

        
        let boundingRect = text.boundingRect(with: NSSize(width: CGFloat.infinity,
                                                          height: CGFloat.infinity),
                                             options: .usesLineFragmentOrigin,
                                             attributes: textFontAttributes)
        
      
        /*
        let textRect: NSRect = NSRect(x: CGFloat(x + xoffset) - padding - (boundingRect.width / 2),
                                          y: CGFloat(y + yoffset) + (boundingRect.height / 2) - padding,
                                          width: boundingRect.width + (padding * 2),
                                          height: boundingRect.height + (padding * 2))
        */
        
        let textRect: NSRect = NSRect(x: CGFloat(x + xoffset) - padding,
                                          y: CGFloat(y + yoffset) - padding,
                                          width: boundingRect.width + (padding * 2),
                                          height: boundingRect.height + (padding * 2))

        
             
        if rotation > -999
        {
            let context = NSGraphicsContext.current!.cgContext
            
            context.translateBy(x:textRect.origin.x, y:textRect.origin.y)
            context.rotate(by: CGFloat(rotation) * CGFloat.pi/180)
            context.translateBy(x:-textRect.origin.x, y:-textRect.origin.y)
        }
        
        
        let borderPath = NSBezierPath(roundedRect: textRect, xRadius: radius, yRadius: radius)
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
        
        text.draw(in: textRect.offsetBy(dx: 0 + padding, dy: 0.0 - padding), withAttributes: textFontAttributes)

        
        postDraw(rect:nil)
    }
}
