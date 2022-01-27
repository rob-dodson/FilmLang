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
            let rectlayer = buildBasicRect()
            
            for animation in animations
            {
                if animation.property == "position" || animation.property.starts(with: "transform.")
                {
                    animation.layer = baseLayer
                }
                else
                {
                    animation.layer = rectlayer
                }
            }
            
            built = true
        }

        
        postDraw()
    }
}
