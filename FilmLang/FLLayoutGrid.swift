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
    var cache  : NSMutableDictionary = NSMutableDictionary()
    
    
    override init(name:String)
    {
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
        cache.removeAllObjects()
        
        baseLayer.removeFromSuperlayer()
        createBaseLayer()
        let rectwidth : CGFloat = (Block.view.frame.width - (viewPadding * 2)) / CGFloat(xcount)
        let rectheight : CGFloat = (Block.view.frame.height - (viewPadding * 2)) / CGFloat(ycount)
        
        width = Block.view.frame.width - (viewPadding * 2) + x * 2
        height = Block.view.frame.height - (viewPadding * 2) + y * 2
        
        for x in 0..<xcount
        {
            for y in 0..<ycount
            {
                let key = "\(x)-\(y)"
                
                let xx = rectwidth * CGFloat(x) + viewPadding / 2
                let yy = rectheight * CGFloat(y) + viewPadding / 2
                
                let rect = FLRect(name: key)
                rect.x = xx.rounded()
                rect.y = yy.rounded()
                rect.width = rectwidth.rounded()
                rect.height = rectheight.rounded()
                rect.strokeWidth = 1.0
                rect.debug = debug
                rect.debugColor = debugColor
                rect.debugFont = debugFont
                rect.strokeColor = NSColor(deviceRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
               
                addChild(childblock: rect)
                cache.setValue(rect, forKey: key)
                
                Block.addLayerToParent(block: self, layer: baseLayer)
            }
        }
    }
    
    
    func getGridRect(x:Int,y:Int) -> FLRect?
    {
        let key = "\(x)-\(y)"
        
        let rect = cache.value(forKey: key)
        
        if let r = rect
        {
            return r as? FLRect
        }
        
        return nil
    }
    
    
    override func draw()
    {
        preDraw()
        
        width = Block.view.frame.width - (viewPadding * 2) + x * 2
        height = Block.view.frame.height - (viewPadding * 2) + y * 2
                
        postDraw()
    }
    
}
