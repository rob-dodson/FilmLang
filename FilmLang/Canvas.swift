//
//  Canvas.swift
//  GraphToad
//
//  Created by Robert Dodson on 9/9/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Cocoa

class Canvas: NSView
{
    var timer : Timer? = nil
   //var screenBlock : Block!
 
    
    required init?(coder: NSCoder)
    {
        //
        // init
        //
        super.init(coder: coder)
        
      
        let js = Javascript(canvas: self)
        js.execScript()
        
        
        if Block.thereAreAnimators
        {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true)
            { (timer) in
                
                if Block.topBlock.animators.count > 0
                {
                    Block.topBlock.animate()
                }
                
                self.animateChildren(children: Block.topBlock.children)
                
                self.needsDisplay = true
            }
        }
        
    }
    
    
    func addBlockFromDictionary(dict:NSDictionary)
    {
        Block.addBlockFromDictionary(dict: dict, view:self)
    }
    
    
    func drawChildren(children:[Block])
    {
        for block in children
        {
            block.draw()
        }
    }
    
    
    func animateChildren(children:[Block])
    {
        for block in children
        {
            if block.animators.count > 0
            {
                block.animate()
            }
        }
        
        for block in children
        {
            if block.children.count > 0
            {
                animateChildren(children: block.children)
            }
        }
    }
    
    
    override func draw(_ dirtyRect: NSRect)
    {
        super.draw(dirtyRect)
        
        //
        // background
        //
        let backPath: NSBezierPath = NSBezierPath(rect: dirtyRect)
        let backColor = NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        backColor.setFill()
        backPath.fill()
        
        //
        // grid
        //
        if let layoutgrid = Block.layoutGrid
        {
            layoutgrid.draw()
        }
        
        //
        // blocks
        //
        Block.topBlock.draw()
        
    }
    
}
