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
 
    
    required init?(coder: NSCoder)
    {
        //
        // init
        //
        super.init(coder: coder)
        Block.view = self
    }
    
    
    func run()
    {
        //
        // parse javascript
        //
        let js = Javascript(canvas: self, parentView: self)
        js.execScript(path:"/Users/robertdodson/Desktop/FILM/FILM.js")
        
        //
        // Animation loop  MAKE THIS MULTI-THREADED!
        //
        if Block.thereAreAnimations
        {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false)
            { (timer) in
                self.animateChildren(children: Block.topBlock.children)
            }
        }
        
        Block.topBlock.draw()
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
            if block.animations.count > 0
            {
                block.runAnimations()
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
  //      Block.topBlock.draw()
        
    }
    
}
