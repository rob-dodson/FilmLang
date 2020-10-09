//
//  FLScrollText.swift
//  FilmLang
//
//  Created by Robert Dodson on 10/8/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

class FLScrollText : Block
{
    var text : String?
    var textURL : String?
    var font : String = "Helvetica"
    var size : CGFloat = 24.0
    var textColor = NSColor.green
    var padding : CGFloat = 0.0
    var boundingtextRect : NSRect!
    
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        //strokeColor = nil
        
        if let textstr = dict["text"]        as? String { text = textstr }
        if let texturl = dict["textURL"]        as? String { textURL = texturl }
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

        
        
        let cliptextRect = NSRect(x: CGFloat(x + xoffset),
                                          y: CGFloat(y + yoffset),
                                          width: width,
                                          height: height)
        
        let borderPath = NSBezierPath(roundedRect: cliptextRect, xRadius: radius, yRadius: radius)
        
        
        if text == nil
         {
             if let url = textURL
             {
                 do
                 {
                     text = try String(contentsOf: URL(fileURLWithPath: url))
                 }
                 catch
                 {
                     print("Error: \(error)")
                     text = "error: url not working"
                 }
             }
             else
             {
                 text = "error: text not set"
             }
        
            boundingtextRect = text!.boundingRect(with: NSSize(width: CGFloat.infinity,
                                                          height: CGFloat.infinity),
                                             options: .usesLineFragmentOrigin,
                                             attributes: textFontAttributes)
        }
        
       
       
        
        let textRect: NSRect = NSRect(x: CGFloat(x + xoffset),
                                          y: CGFloat(y + yoffset) - (boundingtextRect.height - height) - scrollAmount,
                                          width: boundingtextRect.width,
                                          height: boundingtextRect.height)
        
        
        if let strokecolor = strokeColor
        {
            strokecolor.setStroke()
            borderPath.lineWidth = strokeWidth
            borderPath.stroke()
        }
        if clip
        {
          cliptextRect.clip()
        }
        
        if let fillgradient = fillGradient
        {
            fillgradient.draw(in: borderPath, angle: gradientAngle)
        }
        else if let fillcolor = fillColor
        {
            fillcolor.setFill()
            borderPath.fill()
        }
        
        text!.draw(in: textRect, withAttributes: textFontAttributes)
        
        postDraw(rect:nil)
    }
}
