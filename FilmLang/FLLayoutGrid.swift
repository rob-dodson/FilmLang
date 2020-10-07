//
//  FLLayoutGrid.swift
//  FilmLang
//
//  Created by Robert Dodson on 10/3/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class FLLayoutGrid : Block
{
    var xcount : Int = 1
    var ycount : Int = 1
    var cache  : NSMutableDictionary?
    
    
    override init(name:String)
    {
        cache = NSMutableDictionary()
        
        super.init(name: name)
    }
    
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        strokeColor = NSColor.red
        
        if let xcount = dict["xcount"] as? Int { self.xcount = xcount }
        if let ycount = dict["ycount"] as? Int { self.ycount = ycount }
        
        calcGrid()
        
        self.windowChanged =
        {(block) -> Void in
            self.calcGrid()
        }
    }
    
    func calcGrid()
    {
        children.removeAll()
        cache?.removeAllObjects()
        
        let paddingplus = viewPadding / 2
        let paddingminus = viewPadding * 2
        let rectwidth : CGFloat = (Block.view.frame.width - paddingminus) / CGFloat(xcount)
        let rectheight : CGFloat = (Block.view.frame.height - paddingminus) / CGFloat(ycount)

        for x in 1...xcount
        {
            for y in 1...ycount
            {
                let key = "\(x)-\(y)"
                let rect = FLRect(name: "\(name):\(key)")
                rect.x = rectwidth * CGFloat(x - 1) + paddingplus
                rect.y = rectheight * CGFloat(y - 1) + paddingplus
                rect.width = rectwidth
                rect.height = rectheight
                
                if debug == true
                {
                    rect.debug = debug
                    rect.strokeColor = NSColor.red
                }
                
                addChild(childblock: rect)
                cache?.setValue(rect, forKey: key)
            }
        }
    }
    
    
    func getGridRect(x:Int,y:Int) -> FLRect
    {
        let key = "\(x)-\(y)"
        
        return cache?.value(forKey: key) as! FLRect
    }
    
    
    override func draw()
    {
        preDraw()
        
        postDraw(rect: boundingRect)
    }
    
}
