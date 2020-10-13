//
//  FLRect.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/14/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class FLRect : Block
{
    var rectLayer : CALayer!
    var gradLayer : CAGradientLayer?
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
    }
    
    
    override func draw()
    {
        preDraw()
        
        if (fitToView)
        {
            width = (Block.view?.bounds.width)! - (viewPadding * 2)
            height = (Block.view?.bounds.height)! - (viewPadding * 2)
        }
        
        if rectLayer == nil
        {
            rectLayer = CALayer()
            
            let rect = CGRect(x: 0, y: 0,width: width, height: height)
            rectLayer.bounds = rect
            
           // rectLayer.masksToBounds = clip
            
            if let strokecolor = strokeColor
            {
                rectLayer.borderColor = strokecolor.cgColor
                rectLayer.borderWidth = strokeWidth
                rectLayer.cornerRadius = radius
            }
            
            if let fillcolor = fillColor
            {
                rectLayer.backgroundColor = fillcolor.cgColor
            }
            
            if let fillgradient = fillGradient
            {
                gradLayer = CAGradientLayer()
                
                if let gradlayer = gradLayer
                {
                    gradlayer.bounds = rect
                    gradlayer.cornerRadius = radius
                    var color0 = NSColor()
                    var color1 = NSColor()
                    fillgradient.getColor(&color0, location: nil, at: 0)
                    fillgradient.getColor(&color1, location: nil, at: 1)
                    gradlayer.colors = [color0.cgColor,color1.cgColor]
                }
            }
            
            
            baseLayer.bounds = rect
            
            if let gradlayer = gradLayer
            {
                addLayerConstraints(layer:gradlayer)
                baseLayer.addSublayer(gradlayer)
            }
            
            addLayerConstraints(layer:rectLayer)
            baseLayer.addSublayer(rectLayer)
            
            Block.addLayerToParent(block: self, layer: baseLayer)
 
        }
        
        baseLayer.bounds = CGRect(x: 0, y: 0,width: width, height: height)
        baseLayer.position =  CGPoint(x: x + (width / 2), y: y  + (height / 2))
        
        postDraw(rect: boundingRect)
    }
}
