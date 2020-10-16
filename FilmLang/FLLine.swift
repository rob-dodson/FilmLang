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
    var endX               : CGFloat = 1.0
    var endY               : CGFloat = 1.0
    
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let endX = dict["endX"] as? CGFloat { self.endX = endX }
        if let endY = dict["endY"] as? CGFloat { self.endY = endY }
    }
    
    
    override func draw()
    {
        preDraw()
        
        if built == false
        {
            let layer = CAShapeLayer()
            if let strokecolor = strokeColor
            {
                layer.strokeColor = strokecolor.cgColor
                layer.lineWidth = strokeWidth
            }
            
            let line = CGMutablePath()
            line.move(to: NSPoint(x: x + xoffset, y: y + yoffset))
            line.addLine(to: NSPoint(x: endX + xoffset, y: endY + yoffset))
            
            layer.path = line
            
            addLayerConstraints(layer:layer)
            baseLayer.addSublayer(layer)
            baseLayer.zPosition = z
            Block.addLayerToParent(block: self, layer: baseLayer)
        }
           
        if baseLayer.bounds.width != width || baseLayer.bounds.height != height || baseLayer.position.x != x || baseLayer.position.y != y
        {
          //  baseLayer.bounds = CGRect(x: 0, y: 0,width: width, height: height)
          //  baseLayer.position = CGPoint(x: x + xoffset, y: y + yoffset)
        }
        postDraw(rect: nil)
    }
}
