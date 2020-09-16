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
    let name : String
    var amount : Double
    let min : Double
    let max : Double
    let type : AnimatorType
    
    internal init(name: String, amount: Double, min: Double, max: Double, type: Animator.AnimatorType)
    {
        self.name = name
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
}
    

class Block
{
    var parent : Block?
    var children : [Block]
    var name: String
    var x : Double = 10.0
    var y : Double = 10.0
    var fillColor : NSColor = NSColor.darkGray
    var animators : [Animator]
    
    
    init(name:String)
    {
        self.name = name
        self.children = [Block]()
        self.animators = [Animator]()
    }
    
    func animate()
    {
        for index in 0..<animators.count
        {
            if animators[index].name == "x"
            {
                adjust(val:&x, animator: &animators[index])
            }
            else if animators[index].name == "y"
            {
                adjust(val:&y, animator: &animators[index])
            }
            else if animators[index].name == "fillalpha"
            {
                var alpha = Double(fillColor.alphaComponent)
                adjust(val:&alpha, animator: &animators[index])
                fillColor = fillColor.withAlphaComponent(CGFloat(alpha))
            }
        }
    }

    
    func adjust(val:inout Double,animator:inout Animator)
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
    
    
    func offset() -> (Double,Double)
    {
        var x : Double = 0
        var y : Double = 0
        
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
    // must override
    //
    func draw() {}
    
}






