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
            let arclayer = CAShapeLayer()
            
            setColorsOnShapeLayer(layer:arclayer)
            
            let off : CGFloat = 90.0
            let clockwise = false

            let centerPoint = CGPoint(x: x, y: y)
            let arcPath = CGMutablePath()
            
            arcPath.addArc(center: centerPoint,
                           radius: radius,
                           startAngle: CGFloat((startAngle + off) * CGFloat.pi / 180),
                           endAngle: CGFloat((endAngle + off) * CGFloat.pi / 180),
                           clockwise: clockwise,
                           transform:.identity)
            
            if closeArc == true { arcPath.closeSubpath() }
         
            arclayer.path = arcPath
            baseLayer.addSublayer(arclayer)
            //addLayerConstraints(layer:layer)
            Block.addLayerToParent(block: self, layer: baseLayer)
            
            if debug == true
            {
                let debugLayer = CALayer()
                debugLayer.bounds = CGRect(x: 0, y: 0,width: radius * 2, height: radius * 2)
                debugLayer.position = centerPoint
                debugLayer.borderColor = CGColor.init(srgbRed: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
                debugLayer.borderWidth = 0.5
                baseLayer.addSublayer(debugLayer)
            }
            
            for animation in animations
            {
                if animation.property == "position"
                {
                    animation.layer = baseLayer
                }
                else if animation.property == "angles"
                {
                    animation.property = "path"
                    
                    let centerPoint = CGPoint(x: x , y: y )
                    
                   
                    let arcPathfrom = CGMutablePath()
                    arcPathfrom.addArc(center: centerPoint,
                                       radius: radius,
                                       startAngle: CGFloat((animation.fromStartAngle! + off) * CGFloat.pi / 180),
                                       endAngle: CGFloat((animation.fromEndAngle! + off) * CGFloat.pi / 180),
                                       clockwise: clockwise,
                                       transform:.identity)
                    
                    if closeArc == true
                    {
                        arcPathfrom.closeSubpath()
                    }
                    
                    let arcPathto = CGMutablePath()
                    arcPathto.addArc(center: centerPoint,
                                     radius: radius,
                                     startAngle: CGFloat((animation.toStartAngle! + off) * CGFloat.pi / 180),
                                     endAngle: CGFloat((animation.toEndAngle! + off) * CGFloat.pi / 180),
                                     clockwise: clockwise,
                                     transform:.identity)
                    if closeArc == true
                    {
                        arcPathto.closeSubpath()
                    }
                    
                    animation.fromPath = arcPathfrom
                    animation.toPath = arcPathto
                    
                    animation.layer = arclayer
                }
                else
                {
                    animation.layer = arclayer
                }
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

