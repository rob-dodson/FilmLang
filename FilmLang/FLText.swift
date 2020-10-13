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
    
    var gradLayer  : CAGradientLayer!
    var frameLayer : CALayer!
    var textLayer  : CATextLayer!
    var frameRect  : CGRect!
    
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
        
        
        if textLayer == nil
        {
            textLayer = CATextLayer()
            
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .center
            let textFontAttributes = [
                .font: NSFont(name: font, size: size)!,
                .foregroundColor: textColor,
                .paragraphStyle: textStyle,
            ] as [NSAttributedString.Key: Any]
            let textBoundingRect = text.boundingRect(with: NSSize(width: CGFloat.infinity,
                                                                  height: CGFloat.infinity),
                                                     options: .usesLineFragmentOrigin,
                                                     attributes: textFontAttributes)
            
            frameRect = CGRect(x: 0 - padding, y: 0 + padding, width: textBoundingRect.width + (padding * 2), height: textBoundingRect.height + (padding * 2))
            textLayer.bounds = frameRect
            textLayer.fontSize = size
            textLayer.font = CGFont(font as CFString)
            textLayer.foregroundColor = textColor.cgColor
            textLayer.string = NSAttributedString(string: text, attributes: textFontAttributes)
            
            frameRect = CGRect(x: 0, y: 0, width: textBoundingRect.width + (padding * 2), height: textBoundingRect.height + (padding * 2))
            
            if let fillgradient = fillGradient
            {
                gradLayer = CAGradientLayer()
                
                gradLayer.bounds = frameRect
                gradLayer.cornerRadius = radius
                var color0 = NSColor()
                var color1 = NSColor()
                fillgradient.getColor(&color0, location: nil, at: 0)
                fillgradient.getColor(&color1, location: nil, at: 1)
                gradLayer.colors = [color0.cgColor,color1.cgColor]
            }
            
            if strokeColor != nil || fillColor != nil
            {
                frameLayer = CALayer()
                
                frameLayer.bounds = frameRect
                if let strokecolor = strokeColor
                {
                    frameLayer.borderColor = strokecolor.cgColor
                    frameLayer.borderWidth = strokeWidth
                    frameLayer.cornerRadius = radius
                }
                if let fillcolor = fillColor
                {
                    frameLayer.backgroundColor = fillcolor.cgColor
                }
            }
            
            baseLayer.bounds = frameRect
            
            if let gradlayer = gradLayer
            {
                addLayerConstraints(layer:gradlayer)
                baseLayer.addSublayer(gradlayer)
            }
            
            if let framelayer = frameLayer
            {
                addLayerConstraints(layer:framelayer)
                baseLayer.addSublayer(framelayer)
            }
            
            addLayerConstraints(layer:textLayer)
            baseLayer.addSublayer(textLayer)
            
            Block.addLayerToParent(block: self, layer: baseLayer)
        }
        
        
        //
        // update attributes each draw cycle
        //
        //let center = CGPoint(x: x + xoffset + (frameRect.width / 2), y: y + yoffset + (frameRect.height / 2))
        let center = CGPoint(x: x +  (frameRect.width / 2), y: y + (frameRect.height / 2))
        baseLayer.position = center
        
        if rotation > -999
        {
            let transform = CATransform3DMakeRotation(CGFloat(rotation * CGFloat.pi / 180), 0.0, 0.0, 1.0)
            baseLayer.transform = transform
        }
            
        
        postDraw(rect:nil)
    }
}
