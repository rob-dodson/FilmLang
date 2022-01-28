//
//  FLAxis.swift
//  FilmLang
//
//  Created by Robert Dodson on 10/2/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class FLAxis : Block
{
    var points : [NSPoint]
    var axisColor : NSColor?
    
    override init(name:String,type:String)
    {
        points = [NSPoint]()
        axisColor = NSColor.green
        
        super.init(name: name,type:type)
    }
    
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let colorDict = dict["axisColor"] as? NSDictionary { self.axisColor = Block.colorFromDict(dict: colorDict) }
        
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
            //
            // axis
            //
            let layer = newCAShapeLayer()
            setColorsOnShapeLayer(layer:layer)
            
            if let axiscolor = axisColor
            {
                layer.strokeColor = axiscolor.cgColor
            }
            
            let graph = CGMutablePath()
            
            let axis = CGMutablePath()
            axis.move(to: NSPoint(x: x, y: y))
            axis.addLine(to: NSPoint(x: x + width, y: y))
            axis.move(to: NSPoint(x: x, y: y))
            axis.addLine(to: NSPoint(x: x, y: y + height))
            
            graph.addPath(axis)


            //
            // ticks
            //
            let xticks = CGMutablePath()
            let inc : CGFloat = 20
            let ticklen : CGFloat = 5
            for xtick in stride(from: x, to: x + width, by: inc)
            {
                xticks.move(to: NSPoint(x: xtick, y: y - ticklen))
                xticks.addLine(to: NSPoint(x: xtick, y: y + ticklen))
            }
            graph.addPath(xticks)
            

            let yticks = CGMutablePath()
            for ytick in stride(from: y, to: y + height, by: inc)
            {
                yticks.move(to: NSPoint(x: x - ticklen, y: ytick))
                yticks.addLine(to: NSPoint(x: x + ticklen, y: ytick))
            }
            graph.addPath(yticks)
               
            
            //
            // data points
            //
            
            if points.count > 0
            {
                let curveLayer = newCAShapeLayer()
                setColorsOnShapeLayer(layer:curveLayer)
                
                let line = CGMutablePath()
                
                line.move(to: NSPoint(x: x, y: y))
                for point in points
                {
                    line.addLine(to: NSPoint(x: point.x + x, y: point.y + y))
                }
                
                if let fillcolor = fillColor
                {
                    curveLayer.fillColor = fillcolor.cgColor
                }
                else
                {
                    curveLayer.fillColor = nil
                }
                
                curveLayer.path = line
                curveLayer.strokeColor = strokeColor?.cgColor
                curveLayer.lineWidth = strokeWidth
                baseLayer.addSublayer(curveLayer)
            }
            
            layer.path = graph
            baseLayer.addSublayer(layer)
            addLayerConstraints(layer:layer)
            Block.addLayerToParent(block: self, layer: baseLayer)
            
            built = true
        }
        
        
        postDraw()
    }
}
