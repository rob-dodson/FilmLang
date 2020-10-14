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
    var built : Bool = false
    
    
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
            buildBasicRect()
            
            let layer = CAShapeLayer()
            layer.strokeColor = gridColor.cgColor
            layer.lineWidth = gridStrokeWidth
            
            let path = CGMutablePath()
            
            let xaxiscount = Int(width / CGFloat(xspacing))
            for xx in 1...xaxiscount
            {
                let xpos =  (xspacing * CGFloat(xx))
                
                let line = CGMutablePath()
                line.move(to: NSPoint(x: xpos, y: 0))
                line.addLine(to: NSPoint(x: xpos, y:boundingRect.height))
                
                path.addPath(line)
            }
            
            let yaxiscount = Int(height / CGFloat(yspacing))
            for yy in 1...yaxiscount
            {
                let ypos = (yspacing * CGFloat(yy))
                
                let line = CGMutablePath()
                line.move(to: NSPoint(x: 0, y: ypos))
                line.addLine(to: NSPoint(x:boundingRect.width, y: ypos))
                
                path.addPath(line)
            }
            
            layer.path = path
            baseLayer.addSublayer(layer)
            
            built = true
        }
        
        if baseLayer.bounds.width != width || baseLayer.bounds.height != height || baseLayer.position.x != x || baseLayer.position.y != y
        {
            baseLayer.bounds = CGRect(x: 0, y: 0,width: width, height: height)
            baseLayer.position = CGPoint(x: x + xoffset + (width / 2), y: y + yoffset + (height / 2))
        }
        
        postDraw(rect: nil)
    }
}
