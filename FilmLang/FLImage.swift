//
//  FLImage.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/24/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

class FLImage : Block
{
    var url : URL?
    var image : NSImage?
    
    override init(name: String)
    {
        super.init(name: name)
    }
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let urlstr = dict["url"]   as? String
        {
            if let url = URL(string: urlstr)
            {
                image = NSImage(byReferencing: url)
            }
        }
    }
    
    override func draw()
    {
        preDraw()
        
        if built == false
        {
            let layer = CALayer()
            layer.contents = image
            layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
            baseLayer.addSublayer(layer)
            Block.addLayerToParent(block: self, layer: baseLayer)
            
            built = true
        }
        
        if baseLayer.bounds.width != width || baseLayer.bounds.height != height || baseLayer.position.x != x || baseLayer.position.y != y
        {
            baseLayer.bounds = CGRect(x: 0, y: 0,width: width, height: height)
            baseLayer.position = CGPoint(x: x + xoffset + (width / 2), y: y + yoffset + (height / 2))
        }
        
        postDraw(rect:nil)
    }
}
