//
//  FLLine.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/25/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class FLLine : Block
{
    var startX : CGFloat = 0.0
    var startY : CGFloat = 0.0
    var endX   : CGFloat = 1.0
    var endY   : CGFloat = 1.0
   
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        startX = x
        startY = y
        if let endX = dict["endX"] as? CGFloat { self.endX = endX }
        if let endY = dict["endY"] as? CGFloat { self.endY = endY }
    }
    
    
    override func draw()
    {
        preDraw()
        
        if built == false
        {
            let layer = CAShapeLayer()
            
           
            setLayerDefaults(layer:baseLayer)
            setShapeLayerDefaults(layer:layer)
            setColorsOnShapeLayer(layer:layer)
            
            // set baseLayer bounds
            x =  startX > endX ? endX : startX
            y =  startY > endY ? endY : startY
            
            //
            // shift line layer start to 0
            //
            if endX > startX
            {
                endX = endX - startX
                startX = 0
            }
            else
            {
                startX = startX - endX
                endX = 0
            }
            
            if endY > startY
            {
                endY = endY - startY
                startY = 0
            }
            else
            {
                startY = startY - endY
                endY = 0
            }
            
            let line = CGMutablePath()
            line.move(to: NSPoint(x: startX, y: startY))
            line.addLine(to: NSPoint(x: endX , y: endY))
            layer.path = line
            
            
            for animation in animations
            {
                if animation.property == "position"
                {
                    animation.layer = baseLayer
                }
                else
                {
                    animation.layer = layer
                }
            }
            
            addLayerConstraints(layer:layer)
            baseLayer.addSublayer(layer)
            Block.addLayerToParent(block: self, layer: baseLayer)
            
            built = true
        }
       
        width = max(abs(endX - startX),strokeWidth)
        height = max(abs(endY - startY),strokeWidth)
        
        postDraw()
    }
}
