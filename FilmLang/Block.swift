//
//  BlockProtocol.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/13/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa



struct Animator
{
    let val : AnimatorVal
    var amount : CGFloat
    let min : CGFloat
    let max : CGFloat
    let type : AnimatorType
    
    internal init(val: AnimatorVal, amount: CGFloat, min: CGFloat, max: CGFloat, type: Animator.AnimatorType)
    {
        self.val = val
        self.amount = amount
        self.min = min
        self.max = max
        self.type = type
    }
    
    enum AnimatorType
    {
        case Inc
        case Dec
        case Bounce
    }
    
    enum AnimatorVal
    {
        case x
        case y
        case rotation
        case radius
        case startangle
        case endangle
        case fillalpha
    }
}
    

class Block
{
    var parent        : Block?
    var children      : [Block]
    var name          : String
    var x             : CGFloat = 10.0
    var y             : CGFloat = 10.0
    var fillColor     : NSColor?
    var strokeColor   : NSColor?
    var animators     : [Animator]
    var fillGradient  : NSGradient?
    var width         : CGFloat = 111.0
    var height        : CGFloat = 111.0
    var strokeWidth   : CGFloat = 2
    var rotation      : CGFloat = -999
    var raduis        : CGFloat = 4.0
    var debug         : Bool = false
    var gradientAngle : CGFloat = -90
    var clip          : Bool = false
    var radius        : CGFloat = 10.0
    var startAngle    : CGFloat = 0
    var endAngle      : CGFloat = 45
    var view          : NSView?
    var updateSizes   : ((Block) -> Void)?
    
    
    init(name:String, view:NSView?)
    {
        self.name = name
        self.view = view
        
        self.children = [Block]()
        self.animators = [Animator]()
        self.strokeColor = NSColor.green
    }
    
    
    func animate()
    {
        for index in 0..<animators.count
        {
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
        
        if let updater = updateSizes
        {
            updater(self)
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
        
        for block in children
        {
            block.draw()
        }
        
        NSGraphicsContext.restoreGraphicsState()
    }
}






