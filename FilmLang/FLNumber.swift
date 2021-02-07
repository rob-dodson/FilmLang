//
//  FLNumber.swift
//  FilmLang
//
//  Created by Robert Dodson on 2/7/21.
//  Copyright © 2021 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

class FLNumber : Block
{
    var number       : Double = 0.0
    var font         : String = "Helvetica"
    var size         : CGFloat = 24.0
    var textColor    : NSColor = NSColor.green
    var padding      : CGFloat = 0.0
    var frameRect    : CGRect!
    var format       : String = "%f"
    var increment    : Double = 0.0
    var incrementSeconds : Double = 0.0
    var textLayer    : CATextLayer!
    var textFontAttributes : [NSAttributedString.Key: Any]?
    
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let num = dict["number"]          as? Double { number = num }
        if let formatstr = dict["format"]    as? String { format = formatstr }
        if let fontstr = dict["font"]        as? String { font = fontstr }
        if let colordict = dict["textColor"] as? NSDictionary  { textColor = Block.colorFromDict(dict: colordict) }
        if let sizeval = dict["size"]        as? CGFloat { size = sizeval }
        if let paddingval = dict["padding"]  as? CGFloat { padding = paddingval }
        if let incnum = dict["increment"]    as? Double { increment = incnum }
        if let incsecs = dict["incrementSeconds"] as? Double { incrementSeconds = incsecs }
    }
    
    
    override func draw()
    {
        preDraw()
        
        
        if built == false
        {
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .center
            
             textFontAttributes = [
                .font: NSFont(name: font, size: size)!,
                .foregroundColor: textColor,
                .paragraphStyle: textStyle,
            ] as [NSAttributedString.Key: Any]
            
            let text = String(format: format, number)
            let textBoundingRect = text.boundingRect(with: NSSize(width: CGFloat.infinity,
                                                                  height: CGFloat.infinity),
                                                     options: .usesLineFragmentOrigin,
                                                     attributes: textFontAttributes)
            
            
            frameRect = CGRect(x: 0 + padding, y: 0 + padding, width: textBoundingRect.width + (padding * 2), height: textBoundingRect.height + (padding * 2))
            
            if let fillgradient = fillGradient
            {
                let gradLayer = CAGradientLayer()
                gradLayer.bounds = frameRect
                gradLayer.cornerRadius = radius
                var color0 = NSColor()
                var color1 = NSColor()
                fillgradient.getColor(&color0, location: nil, at: 0)
                fillgradient.getColor(&color1, location: nil, at: 1)
                gradLayer.colors = [color0.cgColor,color1.cgColor]
                
                addLayerConstraints(layer:gradLayer)
                baseLayer.addSublayer(gradLayer)
            }
            
            if strokeColor != nil || fillColor != nil
            {
                let frameLayer = CALayer()
                
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
                
                addLayerConstraints(layer:frameLayer)
                baseLayer.addSublayer(frameLayer)
            }
            
            baseLayer.bounds = frameRect
            
            textLayer = CATextLayer()
            let frame = CGRect(x: 0 - padding, y: 0 + padding, width: textBoundingRect.width + (padding * 2), height: textBoundingRect.height + (padding * 2))
            textLayer.bounds = frame
            textLayer.fontSize = size
            textLayer.font = CGFont(font as CFString)
            textLayer.foregroundColor = textColor.cgColor
            textLayer.string = NSAttributedString(string: text, attributes: textFontAttributes)
            
            
            for animation in animations
            {
                if animation.property == "position"
                {
                    animation.layer = baseLayer
                }
                else
                {
                    animation.layer = textLayer
                }
            }
            
            addLayerConstraints(layer:textLayer)
            baseLayer.addSublayer(textLayer)
            Block.addLayerToParent(block: self, layer: baseLayer)
            
            built = true
        }
        
        width = frameRect.width
        height = frameRect.height
        
        postDraw()
    }
    
    
    override func start()
    {
        if incrementSeconds > 0.0 && timer == nil
        {
            timer = Timer.scheduledTimer(withTimeInterval: incrementSeconds, repeats: true)
            { (timer) in
                
                self.number += self.increment
                let text = String(format: self.format,self.number)
                self.textLayer.string = NSAttributedString(string: text, attributes: self.textFontAttributes)
            }
        }
    }
}
