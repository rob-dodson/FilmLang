//
//  BlockProtocol.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/13/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa



class Block
{
    var parent        : Block?
    var children      : [Block]
    var name          : String
    var x             : CGFloat = 10.0
    var y             : CGFloat = 10.0
    var fillColor     : NSColor?
    var strokeColor   : NSColor?
    var strokeAlpha   : CGFloat = -1.0
    var animators     : [Animator]
    var fillGradient  : NSGradient?
    var width         : CGFloat = 111.0
    var height        : CGFloat = 111.0
    var strokeWidth   : CGFloat = 2
    var rotation      : CGFloat = -999
    var debug         : Bool = false
    var gradientAngle : CGFloat = -90
    var clip          : Bool = false
    var radius        : CGFloat = 0.0
    var startAngle    : CGFloat = 0
    var endAngle      : CGFloat = 45
    var view          : NSView?
    var windowChanged : ((Block) -> Void)?
    var boundingRect  : NSRect? = nil
    var xoffset       : CGFloat = 0.0
    var yoffset       : CGFloat = 0.0
    var windowWidthOffset  : CGFloat = 0.0
    var windowHeightOffset : CGFloat = 0.0
    var fitToView          : Bool = false
    
    
    
    init(name:String, view:NSView?)
    {
        self.name = name
        self.view = view
        
        self.children = [Block]()
        self.animators = [Animator]()
    }
    
    
    func animate()
    {
        for index in 0..<animators.count
        {
            if let winchange = animators[index].windowChanged
            {
                winchange(animators[index])
            }
            
            switch animators[index].val
            {
            case .x:
                adjust(val:&x, animator: &animators[index])
                
            case.y:
                adjust(val:&y, animator: &animators[index])
                
            case .rotation:
                adjust(val:&rotation, animator: &animators[index])
                
            case .radius:
                adjust(val:&radius, animator: &animators[index])
                
            case .startangle:
                adjust(val:&startAngle, animator: &animators[index])
                
            case .endangle:
                adjust(val:&endAngle, animator: &animators[index])
                
            case .fillalpha:
                if fillColor != nil
                {
                    var alpha = CGFloat(fillColor!.alphaComponent)
                    adjust(val:&alpha, animator: &animators[index])
                    fillColor = fillColor!.withAlphaComponent(CGFloat(alpha))
                }
            case .strokewidth:
                adjust(val:&strokeWidth, animator: &animators[index])
                
            case .strokealpha:
                adjust(val:&strokeAlpha, animator: &animators[index])
            }
        }
    }

    
    func adjust(val:inout CGFloat,animator:inout Animator)
    {
        if animator.type == .Inc
        {
            val = val + animator.amount
            if val > animator.max { val = animator.min }
        }
        else if animator.type == .Dec
        {
            val = val - animator.amount
            if val < animator.min { val = animator.max }
        }
        else if animator.type == .Bounce
        {
            val = val + animator.amount
            if val > animator.max
            {
                animator.amount = -animator.amount
            }
            else if val < animator.min
            {
                animator.amount = abs(animator.amount)
            }
        }
    }
    
    
    func addChild(block:Block)
    {
        children.append(block);
        block.parent = self;
    }
    
    
    func offset() -> (CGFloat,CGFloat)
    {
        var x : CGFloat = 0
        var y : CGFloat = 0
        
        var p = parent
        while p != nil
        {
            x = x + p!.x
            y = y + p!.y
            p = p?.parent
        }
        return (x,y)
    }
    
    
    //
    // subclass must override
    //
    func draw()
    {
        preDraw()
        
        postDraw(rect: nil)
    }
   
    
    //
    // must be called from subclass's draw().
    // postDraw will daw children
    //
    func preDraw()
    {
        NSGraphicsContext.saveGraphicsState()
        
        if let winchange = windowChanged
        {
            winchange(self)
        }

        (xoffset,yoffset) = offset()
        boundingRect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)
        
        if rotation > -999
        {
            let context = NSGraphicsContext.current!.cgContext
            
            if let rect = boundingRect
            {
                context.translateBy(x:rect.origin.x, y:rect.origin.y)
                context.rotate(by: CGFloat(rotation) * CGFloat.pi/180)
                context.translateBy(x:-rect.origin.x, y:-rect.origin.y)
            }
        }
        
        if strokeAlpha > 0.0
        {
            strokeColor = strokeColor?.withAlphaComponent(strokeAlpha)
        }

    }
    
    func postDraw(rect:NSRect?)
    {
        if debug == true && rect != nil
        {
            let rectangleStyle = NSMutableParagraphStyle()
            rectangleStyle.alignment = .center
            let rectangleFontAttributes = [
                .font: NSFont(name: "Futura", size: 12)!,
                .foregroundColor: NSColor.white,
                .paragraphStyle: rectangleStyle,
            ] as [NSAttributedString.Key: Any]
            name.draw(in: rect!.offsetBy(dx: 0, dy: -4), withAttributes: rectangleFontAttributes)
        }
        
        if clip == true && rect != nil
        {
            rect!.clip()
        }
        
        for block in children
        {
            block.draw()
        }
        
        NSGraphicsContext.restoreGraphicsState()
    }
}






