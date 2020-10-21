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
    var animationController : AnimationController!
    
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
        
        if built == false
        {
            animationController = AnimationController()
            
            buildBasicRect()
            
            built = true
        }

        if baseLayer.bounds.width != width || baseLayer.bounds.height != height || baseLayer.position.x != x || baseLayer.position.y != y
        {
            baseLayer.bounds = CGRect(x: 0, y: 0,width: width, height: height)
            baseLayer.position = CGPoint(x: x + xoffset + (width / 2), y: y + yoffset + (height / 2))
        }
        
        
        if animationController.animationGoing == false && self.animators.count > 0
        {
            let animator = self.animators[0]
            let fromValue = baseLayer.position
            let toValue = CGPoint(x: x + xoffset + (width / 2) + animator.max, y: y + yoffset + (height / 2))
            
            animationController.startAnimation(layer: baseLayer, property: "position", tovalue: toValue, fromvalue: fromValue, duration: CFTimeInterval(5.0))
        }
        
        postDraw(rect: boundingRect)
    }
}
