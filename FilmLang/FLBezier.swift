//
//  FLBezier.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/28/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

struct BezPoint
{
    internal init(point: NSPoint, controlPoint1: NSPoint?, controlPoint2: NSPoint?)
    {
        self.point = point
        self.controlPoint1 = controlPoint1
        self.controlPoint2 = controlPoint2
    }
    
    let point : NSPoint
    let controlPoint1 : NSPoint?
    let controlPoint2 : NSPoint?
}

class FLBezier : Block
{
    var bezpoints : [BezPoint]
    
    override init(name:String,type:String)
    {
        bezpoints = [BezPoint]()
        
        super.init(name: name,type:type)
    }
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        
        for i in 0...100
        {
            if let bdict = dict["point\(i)"] as? NSDictionary
            {
                if bdict["point"] != nil
                {
                    var point = Block.pointFromDict(dict: bdict["point"] as! NSDictionary)
                    var controlpoint1 = Block.pointFromDict(dict: bdict["controlPoint1"] as! NSDictionary)
                    var controlpoint2 = Block.pointFromDict(dict: bdict["controlPoint2"] as! NSDictionary)
                    
                    point.x *= scalePath
                    point.y *= scalePath
                    controlpoint1.x *= scalePath
                    controlpoint1.y *= scalePath
                    controlpoint2.x *= scalePath
                    controlpoint2.y *= scalePath
                    
                    let bezpoint = BezPoint(point: point, controlPoint1: controlpoint1, controlPoint2:controlpoint2)
                    
                    bezpoints.append(bezpoint)
                }
                else if bdict["x"] != nil
                {
                    var point = Block.pointFromDict(dict: bdict)
                    
                    point.x *= scalePath
                    point.y *= scalePath
                    
                    let bezpoint = BezPoint(point: point, controlPoint1: nil, controlPoint2:nil)
                    
                    bezpoints.append(bezpoint)
                }
                
            }
        }
    }
    
    
    override func draw()
    {
        preDraw()
        
        if built == false
        {
            let layer = CAShapeLayer()
            setLayerDefaults(layer:baseLayer)
            setColorsOnShapeLayer(layer:layer)
            setShapeLayerDefaults(layer:layer)
        
            let path = CGMutablePath()
            
            var count = 0
            for bezpoint in bezpoints
            {
                if bezpoint.controlPoint1 == nil && bezpoint.controlPoint2 == nil
                {
                    if count == 0
                    {
                        path.move(to: bezpoint.point)
                    }
                    else
                    {
                        path.addLine(to: bezpoint.point)
                    }
                    count = count + 1
                    
                    if debug
                    {
                        addDebugRect(point:bezpoint.point,color:NSColor.green)
                    }
                   
                }
                else
                {
                    path.addCurve(to: bezpoint.point, control1: bezpoint.controlPoint1!, control2: bezpoint.controlPoint2!)
                    
                    if debug
                    {
                        addDebugRect(point:bezpoint.point,color:NSColor.red)
                        addDebugRect(point:bezpoint.controlPoint1!,color:NSColor.purple)
                        addDebugRect(point:bezpoint.controlPoint2!,color:NSColor.blue)
                    }
                }
            }
            
            if closePath == true
            {
                path.closeSubpath()
            }
            
            layer.path = path
            
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
            
            
            width = path.boundingBox.width
            height = path.boundingBox.height
            
            addLayerConstraints(layer:layer)
            baseLayer.addSublayer(layer)
            Block.addLayerToParent(block: self, layer: baseLayer)
            
            built = true
        }
        
        
        postDraw()
    }
}
       
