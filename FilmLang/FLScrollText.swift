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
    var text : String!
    var textURL : String?
    var font : String = "Helvetica"
    var size : CGFloat = 24.0
    var textColor = NSColor.green
    var padding : CGFloat = 0.0
    var boundingtextRect : NSRect!
    var scrollLayer = CAScrollLayer()
    var textpadding : CGFloat = 5.0
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
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
        
        if built == false
        {
            scrollLayer.bounds = CGRect(x: 0.0, y: 0.0, width: width, height: height)
            scrollLayer.position = CGPoint(x: x + xoffset + (width / 2), y: y + yoffset + (height / 2))
            scrollLayer.borderColor = strokeColor?.cgColor
            scrollLayer.borderWidth = strokeWidth
            scrollLayer.scrollMode = CAScrollLayerScrollMode.vertically
          
            
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
            }
            
            
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .left
            let textFontAttributes = [
                .font: NSFont(name: font, size: size)!,
                .foregroundColor: textColor,
                .paragraphStyle: textStyle,
            ] as [NSAttributedString.Key: Any]

            boundingtextRect = text!.boundingRect(with: NSSize(width: CGFloat.infinity,
                                                          height: CGFloat.infinity),
                                             options: .usesLineFragmentOrigin,
                                             attributes: textFontAttributes)
            
            let textLayer = CATextLayer()
            
            textLayer.bounds = CGRect(x: 0, y: 0, width: width - (textpadding * 2), height: boundingtextRect.height)
            textLayer.position = CGPoint(x: width / 2 + textpadding, y: height / 2)
            textLayer.fontSize = size
            textLayer.font = CGFont(font as CFString)
            textLayer.foregroundColor = textColor.cgColor
            textLayer.isWrapped = true
            textLayer.string = NSAttributedString(string: text, attributes: textFontAttributes)
       
            scrollLayer.addSublayer(textLayer)
           
            Block.addLayerToParent(block: self, layer: scrollLayer)
            
            for animation in animations
            {
                if animation.property == "position"
                {
                    animation.layer = baseLayer
                }
                else if animation.property == "scrollamount"
                {
                    animation.property = "position"
                    animation.layer = textLayer
                    animation.toPoint = CGPoint(x: width / 2 + textpadding, y: (height / 2) - animation.max)
                    animation.fromPoint = CGPoint(x: width / 2 + textpadding, y: height / 2)
                }
            }
            
            built = true
        }
        scrollLayer.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        scrollLayer.position = CGPoint(x: x + xoffset + (width / 2), y: y + yoffset + (height / 2))
        
        
        postDraw()
    }
}
