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
    var circleLayer : CAShapeLayer!
    var rect : NSRect!
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
    }
    
    
    override func draw()
    {
        preDraw()
        
        if circleLayer == nil
        {
            circleLayer = CAShapeLayer()
            
            if radius > 0.0
            {
                rect = NSRect(x: (x + xoffset) - radius, y: (y + yoffset) - radius, width: radius * 2, height: radius * 2)
            }
            else
            {
                rect = NSRect(x: x + xoffset - (width / 2), y: y + yoffset - (height / 2), width:width, height: width)
            }
            circleLayer.bounds = rect!
            
            
            let ovalPath = CGPath(ellipseIn: rect!, transform: nil)
            circleLayer.path = ovalPath
            
            if let fillcolor = fillColor
            {
                circleLayer.fillColor = fillcolor.cgColor
            }
            
            if let strokecolor = strokeColor
            {
                circleLayer.strokeColor = strokecolor.cgColor
                circleLayer.lineWidth = strokeWidth
            }
            
            
            addLayerConstraints(layer:circleLayer)
            baseLayer.addSublayer(circleLayer)
            
            Block.addLayerToParent(block: self, layer: baseLayer)
        }
        
        baseLayer.position =  CGPoint(x: x + xoffset, y: y + yoffset)
        
        postDraw(rect:rect)
    }

}

