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
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
    }
    
    
    override func draw()
    {
        preDraw()
        
        if built == false
        {
            let rect = NSRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
            
            let circleLayer =  newCAShapeLayer()
            setColorsOnShapeLayer(layer:circleLayer)
            
            let ovalPath = CGPath(ellipseIn: rect, transform: nil)
            circleLayer.path = ovalPath
            
            for animation in animations
            {
                if animation.property == "position"
                {
                    animation.layer = baseLayer
                }
                else if animation.property == "radius"
                {
                    animation.property = "path"
                    
                    let fromrect = NSRect(x: 0, y: 0, width:animation.from! * 2, height:animation.from! * 2)
                    animation.fromPath = CGPath(ellipseIn: fromrect, transform: nil)
                    
                    let torect = NSRect(x: 0, y: 0, width: animation.to! * 2, height: animation.to! * 2)
                    animation.toPath = CGPath(ellipseIn: torect, transform: nil)
                    
                    animation.layer = circleLayer
                }
                else if animation.property.starts(with: "transform.")
                {
                    animation.layer = baseLayer
                }
                else
                {
                    animation.layer = circleLayer
                }
            }
            
            addLayerConstraints(layer:circleLayer)
            baseLayer.addSublayer(circleLayer)
            Block.addLayerToParent(block: self, layer: baseLayer)
            
            x = x - radius
            y = y - radius
           
            built = true
        }
        width = radius * 2
        height = radius * 2
        
        postDraw()
    }

}

