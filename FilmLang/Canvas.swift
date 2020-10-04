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
    var screenBlock : Block!
 
    
    required init?(coder: NSCoder)
    {
        //
        // init
        //
        screenBlock = FLRect(name:"Screen",view:nil)
        Block.topBlock = screenBlock
        super.init(coder: coder)
        screenBlock.view = self
        
        
        screenBlock.x = screenBlock.viewPadding
        screenBlock.y = screenBlock.viewPadding
        screenBlock.width = 1000
        screenBlock.height = 700
        screenBlock.gradientAngle = -50
        screenBlock.clip = true
        screenBlock.fitToView = true
        screenBlock.fillGradient = NSGradient(starting: NSColor.init(calibratedRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.0), ending: NSColor.init(calibratedRed: 0.0, green: 0.4, blue: 0.0, alpha: 5.0))!
        screenBlock.windowChanged =
        {(block) -> Void in
            block.width = self.frame.width - (self.screenBlock.viewPadding * 2)
            block.height = self.frame.height - (self.screenBlock.viewPadding * 2)
        }
        
        
        let js = Javascript(canvas: self)
        js.execScript()
        
        
        if Block.thereAreAnimators
        {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true)
            { (timer) in
                
                if self.screenBlock.animators.count > 0
                {
                    self.screenBlock.animate()
                }
                
                self.animateChildren(children: self.screenBlock.children)
                
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
        screenBlock.draw()
        
    }
    
}
