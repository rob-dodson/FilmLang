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
    var layer : CATextLayer!
    var gradientLayer : CAGradientLayer?
    var rect : CGRect?
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let textstr = dict["text"]        as? String { text = textstr }
        if let fontstr = dict["font"]        as? String { font = fontstr }
        if let colordict = dict["textColor"] as? NSDictionary  { textColor = Block.colorFromDict(dict: colordict) }
        if let size = dict["size"]           as? CGFloat { self.size = size }
        if let padding = dict["padding"]     as? CGFloat { self.padding = padding }
    }
    
    
    override func draw()
    {
        preDraw()
        
        
        if layer == nil
        {
            layer = CATextLayer()
            
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .left
            let textFontAttributes = [
                .font: NSFont(name: font, size: size)!,
                .foregroundColor: textColor,
                .paragraphStyle: textStyle,
            ] as [NSAttributedString.Key: Any]
            let textBoundingRect = text.boundingRect(with: NSSize(width: CGFloat.infinity,
                                                                  height: CGFloat.infinity),
                                                     options: .usesLineFragmentOrigin,
                                                     attributes: textFontAttributes)
            
            rect = CGRect(x: 0,
                          y: 0,
                          width: textBoundingRect.width,
                          height: textBoundingRect.height)
            
            layer.bounds = rect!
            layer.fontSize = size
            layer.font = CGFont(font as CFString)
            layer.foregroundColor = textColor.cgColor
            layer.string = text
            
            
            if let strokecolor = strokeColor
            {
                layer.borderColor = strokecolor.cgColor
                layer.borderWidth = strokeWidth
                layer.cornerRadius = radius
            }
            
            if let fillcolor = fillColor
            {
                layer.backgroundColor = fillcolor.cgColor
            }
            
            if let fillgradient = fillGradient
            {
                gradientLayer = CAGradientLayer()
                
                if let gradlayer = gradientLayer
                {
                    gradlayer.bounds = rect!
                    
                    gradlayer.cornerRadius = radius
                    var color0 = NSColor()
                    var color1 = NSColor()
                    fillgradient.getColor(&color0, location: nil, at: 0)
                    fillgradient.getColor(&color1, location: nil, at: 1)
                    gradlayer.colors = [color0.cgColor,color1.cgColor]
                    
                    Block.view.layer?.insertSublayer(gradlayer, below: layer)
                }
            }
            
            Block.view.layer?.addSublayer(layer)
        }
        
        let center = CGPoint(x: x + xoffset + (rect!.width / 2),
                             y: y + yoffset + (rect!.height / 2))
        
        layer.position = center
        if let gradlayer = gradientLayer
        {
            gradlayer.position = center
        }
  
        
        
        postDraw(rect:nil)
    }
}
