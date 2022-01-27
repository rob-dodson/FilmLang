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
    internal init(point: NSPoint?, controlPoint1: NSPoint?, controlPoint2: NSPoint?,close:Bool)
    {
        self.point = point
        self.controlPoint1 = controlPoint1
        self.controlPoint2 = controlPoint2
        self.close = close
    }
    
    
    let point : NSPoint?
    let controlPoint1 : NSPoint?
    let controlPoint2 : NSPoint?
    let close : Bool
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
                    
                    let bezpoint = BezPoint(point: point, controlPoint1: controlpoint1, controlPoint2:controlpoint2,close:false)
                    
                    bezpoints.append(bezpoint)
                }
                else if let cmd = bdict["cmd"] as? String
                {
                    if cmd == "close"
                    {
                        let bezpoint = BezPoint(point: nil, controlPoint1: nil, controlPoint2:nil,close:true)
                        bezpoints.append(bezpoint)
                    }
                }
                else if bdict["x"] != nil
                {
                    var point = Block.pointFromDict(dict: bdict)
                    
                    point.x *= scalePath
                    point.y *= scalePath
                    
                    let bezpoint = BezPoint(point: point, controlPoint1: nil, controlPoint2:nil,close:false)
                    
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
            let layer = newCAShapeLayer()
            setColorsOnShapeLayer(layer:layer)
        
            let path = CGMutablePath()
            
            var closed = true
            for bezpoint in bezpoints
            {
                if bezpoint.close == true
                {
                    path.closeSubpath()
                    closed = true
                }
                else if bezpoint.controlPoint1 == nil && bezpoint.controlPoint2 == nil
                {
                    if closed
                    {
                        path.move(to: bezpoint.point!)
                        closed = false
                    }
                    else
                    {
                        path.addLine(to: bezpoint.point!)
                    }
                    
                    if debug
                    {
                        addDebugRect(point:bezpoint.point!,color:NSColor.green)
                    }
                   
                }
                else
                {
                    path.addCurve(to: bezpoint.point!, control1: bezpoint.controlPoint1!, control2: bezpoint.controlPoint2!)
                    
                    if debug
                    {
                        addDebugRect(point:bezpoint.point!,color:NSColor.red)
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
                if animation.property == "position" || animation.property.starts(with: "transform.")
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
       
