//
//  FLPath.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/14/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

class FLPath : Block
{
    var points : [NSPoint]
    
    override init(name:String)
    {
        points = [NSPoint]()
        
        super.init(name: name)
    }
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        for i in 0...100
        {
            let key = "point\(i)"
            if let dict = dict[key]
            {
                self.points.append(Block.pointFromDict(dict:dict as! NSDictionary))
            }
        }
    }
    
    override func draw()
    {
        preDraw()
        
        if built == false
        {
            let layer = CAShapeLayer()
            layer.lineCap = .round
            setColorsOnShapeLayer(layer:layer)
            
            let path = CGMutablePath()
            path.move(to: NSPoint(x: xoffset + x, y: yoffset + y))
            for point in points
            {
                path.addLine(to: NSPoint(x: point.x + xoffset, y: point.y + yoffset))
            }

            layer.path = path
            baseLayer.addSublayer(layer)
            addLayerConstraints(layer:layer)
            Block.addLayerToParent(block: self, layer: baseLayer)
            
            built = true
        }
        
        postDraw()
    }
}
       
