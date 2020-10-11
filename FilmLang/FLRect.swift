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
    var layer : CALayer!
    var gradientLayer : CAGradientLayer?
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
    }
    
    
    override func draw()
    {
        preDraw()
        
        if (fitToView)
        {
            width = (Block.view?.frame.width)! - (viewPadding * 2)
            height = (Block.view?.frame.height)! - (viewPadding * 2)
        }
        
        if layer == nil
        {
            layer = CALayer()
            layer.masksToBounds = clip
            layer.bounds = CGRect(x: 0, y: 0,width: width, height: height)
            
            if let strokecolor = strokeColor
            {
                layer.borderColor = strokecolor.cgColor
                layer.borderWidth = strokeWidth
                layer.cornerRadius = radius
            }
            
            if let fillcolor = fillColor
            {
                layer.backgroundColor = fillcolor.cgColor
            }
            
            if let fillgradient = fillGradient
            {
                gradientLayer = CAGradientLayer()
                
                if let gradlayer = gradientLayer
                {
                    gradlayer.bounds = CGRect(x: 0, y: 0, width: width, height: height)
                    
                    gradlayer.cornerRadius = radius
                    var color0 = NSColor()
                    var color1 = NSColor()
                    fillgradient.getColor(&color0, location: nil, at: 0)
                    fillgradient.getColor(&color1, location: nil, at: 1)
                    gradlayer.colors = [color0.cgColor,color1.cgColor]
                    
                    Block.view.layer?.insertSublayer(gradlayer, below: layer)
                }
            }
            
            Block.view.layer?.addSublayer(layer)
       }
        
        let bounds = CGRect(x: 0, y: 0,width: width, height: height)
        let center = CGPoint(x:boundingRect.origin.x + (width / 2),y:boundingRect.origin.y + (height / 2))
        
        layer.bounds = bounds
        layer.position = center
        if let gradlayer = gradientLayer
        {
            gradlayer.bounds = bounds
            gradlayer.position = center
        }
        
        
        
        
        
        
        postDraw(rect: boundingRect)
        
    }
}
