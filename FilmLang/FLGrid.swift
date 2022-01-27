//
//  FLGrid.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/14/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class FLGrid : Block
{
    var xspacing : CGFloat = 10
    var yspacing : CGFloat = 10
    var gridColor = NSColor.green
    var gridStrokeWidth : CGFloat = 0.5
    
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let xspacing = dict["xspacing"]   as? CGFloat { self.xspacing = xspacing }
        if let yspacing = dict["yspacing"]   as? CGFloat { self.yspacing = yspacing }
        if let colordict = dict["gridColor"] as? NSDictionary  { self.gridColor = Block.colorFromDict(dict: colordict) }
        if let gridStrokeWidth = dict["gridStrokeWidth"]   as? CGFloat { self.gridStrokeWidth = gridStrokeWidth }
    }
    
    
    override func draw()
    {
        preDraw()
        
        if (fitToView)
        {
            width = (Block.view.frame.width) - (viewPadding * 2)
            height = (Block.view.frame.height) - (viewPadding * 2)
        }
        
        
        if built == false
        {
            _ = buildBasicRect()
            
            let layer = CAShapeLayer()
            layer.strokeColor = gridColor.cgColor
            layer.lineWidth = gridStrokeWidth
            
            let path = CGMutablePath()
            
            let xaxiscount = Int(width / CGFloat(xspacing))
            for xx in 0...xaxiscount
            {
                let xpos =  (xspacing * CGFloat(xx))
                
                let line = CGMutablePath()
                line.move(to: NSPoint(x: xpos, y: 0))
                line.addLine(to: NSPoint(x: xpos, y:boundingRect.height))
                
                path.addPath(line)
            }
            
            let yaxiscount = Int(height / CGFloat(yspacing))
            for yy in 0...yaxiscount
            {
                let ypos = (yspacing * CGFloat(yy))
                
                let line = CGMutablePath()
                line.move(to: NSPoint(x: 0, y: ypos))
                line.addLine(to: NSPoint(x:boundingRect.width, y: ypos))
                
                path.addPath(line)
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
            
            
            baseLayer.addSublayer(layer)
            
            built = true
        }
        
        
        postDraw()
    }
}
