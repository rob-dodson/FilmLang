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
    var rect : NSRect!
    var rectLayer  : CALayer!
    
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
            
            setColorsOnShapeLayer(layer:layer)
            
            let arcPath = CGMutablePath()
            
            let centerPoint = CGPoint(x: x + parent!.width / 2, y: y + parent!.height / 2)
            
            arcPath.addArc(center: centerPoint, radius: radius, startAngle: CGFloat(startAngle * CGFloat.pi / 180), endAngle: CGFloat(endAngle * CGFloat.pi / 180), clockwise: true, transform:.identity)
            if closeArc == true
            {
                arcPath.closeSubpath()
            }
         
            layer.path = arcPath
            baseLayer.addSublayer(layer)
            //addLayerConstraints(layer:layer)
            Block.addLayerToParent(block: self, layer: baseLayer)
            
            if debug == true
            {
                rect = arcPath.boundingBox
                rectLayer = CALayer()
                rectLayer.bounds = CGRect(x: 0, y: 0,width: radius * 2, height: radius * 2)
                rectLayer.position = centerPoint
                rectLayer.borderColor = CGColor.init(srgbRed: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
                rectLayer.borderWidth = 1
                baseLayer.addSublayer(rectLayer)
            }
            
            built = true
        }
        
        if baseLayer.bounds.width != width || baseLayer.bounds.height != height || baseLayer.position.x != x || baseLayer.position.y != y
        {
            baseLayer.bounds = CGRect(x: 0, y: 0,width: radius * 2, height: radius * 2)
            baseLayer.position = CGPoint(x: x + parent!.width / 2, y: y + parent!.height / 2)
        }
        
        postDraw(rect:nil)
    }

}

