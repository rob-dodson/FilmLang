//
//  FLCircle.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/14/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

class FLCircle : Block
{
    var rect : NSRect!
   
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
    }
    
    
    override func draw()
    {
        preDraw()
        
        if built == false
        {
            if radius > 0.0
            {
                rect = NSRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
            }
            else
            {
                rect = NSRect(x: 0, y: 0, width:width, height: width)
            }
            
            let circleLayer = CAShapeLayer()
            
            let ovalPath = CGPath(ellipseIn: rect!, transform: nil)
            circleLayer.path = ovalPath
            
            if let fillcolor = fillColor
            {
                circleLayer.fillColor = fillcolor.cgColor
            }
            else
            {
                circleLayer.fillColor = nil
            }
            
            if let strokecolor = strokeColor
            {
                circleLayer.strokeColor = strokecolor.cgColor
                circleLayer.lineWidth = strokeWidth
            }
            
            
            addLayerConstraints(layer:circleLayer)
            baseLayer.addSublayer(circleLayer)
            Block.addLayerToParent(block: self, layer: baseLayer)
            
            if debug == true
            {
                let debugLayer = CALayer()
                debugLayer.bounds = CGRect(x: 0, y: 0,width: rect.width, height: rect.height)
                debugLayer.position = CGPoint(x: rect.width / 2, y: rect.height / 2)
                debugLayer.borderColor = CGColor.init(srgbRed: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
                debugLayer.borderWidth = 1
                baseLayer.addSublayer(debugLayer)
            }
            
            built = true
        }
        
        width = radius * 2
        height = radius * 2
        baseLayer.position = CGPoint(x: x + xoffset - radius, y: y + yoffset - radius)
        
        postDraw(rect:rect)
    }

}

