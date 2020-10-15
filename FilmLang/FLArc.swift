//
//  FLArc.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/21/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//
import Foundation
import Cocoa

class FLArc : Block
{
    var closeArc : Bool = false
    var built : Bool = false
    var debugrect : NSRect!
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let startAngle = dict["startAngle"] as? CGFloat { self.startAngle = startAngle }
        if let endAngle = dict["endAngle"]     as? CGFloat { self.endAngle = endAngle }
        if let closeArc = dict["closeArc"]     as? Bool { self.closeArc = closeArc }
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
            if let fillcolor = fillColor
            {
                layer.fillColor = fillcolor.cgColor
            }
            else
            {
                layer.fillColor = nil
            }
            
            let arcPath = CGMutablePath()
            
            let startPoint = NSPoint(x: x + xoffset, y: y + yoffset)
            
            arcPath.addArc(center: startPoint, radius: radius, startAngle: CGFloat(startAngle * CGFloat.pi / 180), endAngle: CGFloat(endAngle * CGFloat.pi / 180), clockwise: true, transform:.identity)
            if closeArc == true
            {
                arcPath.closeSubpath()
            }
         
            layer.path = arcPath
            baseLayer.addSublayer(layer)
            Block.addLayerToParent(block: self, layer: baseLayer)
            
            debugrect = arcPath.boundingBox
            built = true
        }
        
        if baseLayer.bounds.width != width || baseLayer.bounds.height != height || baseLayer.position.x != x || baseLayer.position.y != y
        {
            baseLayer.bounds = CGRect(x: 0, y: 0,width: width, height: height)
            baseLayer.position = CGPoint(x: x + xoffset + (width / 2), y: y + yoffset + (height / 2))
        }
        
        postDraw(rect:debugrect)
    }

}

