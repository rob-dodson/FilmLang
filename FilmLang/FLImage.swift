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
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let urlstr = dict["url"]   as? String
        {
            self.url = URL(string: urlstr)
        }
    }
    
    override func draw()
    {
        preDraw()
        
        var xoffset : CGFloat
        var yoffset : CGFloat
        (xoffset,yoffset) = offset()
        
        let rect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)

        if image == nil && url != nil
        {
            image = NSImage.init(byReferencing: url!)
        }
        
        image?.draw(in: rect)
        
        postDraw(rect:nil)
    }
}
