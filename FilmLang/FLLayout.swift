//
//  FLLayout.swift
//  FilmLang
//
//  Created by Robert Dodson on 10/3/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class FLLayout : Block
{
    var xcount : Int = 1
    var ycount : Int = 1
    
    override init(name:String, view:NSView?)
    {
        super.init(name: name, view: view)
    }
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        strokeColor = NSColor.red
        if let xcount = dict["xcount"] as? Int { self.xcount = xcount }
        if let ycount = dict["ycount"] as? Int { self.ycount = ycount }
        
        let rectwidth : CGFloat = view!.frame.width / CGFloat(xcount)
        let rectheight : CGFloat = view!.frame.height / CGFloat(ycount)
        
        for x in 0...xcount
        {
            for y in 0...ycount
            {
                let rect = FLRect(name: "\(name):\(x)\(y)", view: view)
                rect.x = rectwidth * CGFloat(x)
                rect.y = rectheight * CGFloat(y)
                rect.width = rectwidth
                rect.height = rectheight
                if debug == true
                {
                    rect.debug = debug
                    rect.strokeColor = NSColor.red
                }
                addChild(block: rect)
            }
        }
    }
    
    override func draw()
    {
        preDraw()
        
        postDraw(rect: boundingRect)
    }
    
}
