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
    let amount : Double
    let min : Double
    let max : Double
    var up : Bool
    let type : AnimatorType
    
    internal init(name: String, amount: Double, min: Double, max: Double, up: Bool, type: Animator.AnimatorType)
    {
        self.name = name
        self.amount = amount
        self.min = min
        self.max = max
        self.up = up
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
    var animators : [Animator]
    
    init(name:String)
    {
        self.name = name
        self.children = [Block]()
        self.animators = [Animator]()
    }
    
    func adjust(obj:inout Double,animator:inout Animator)
    {
        if animator.type == .Inc
        {
            obj = obj + animator.amount
            if obj > animator.max { obj = animator.min }
        }
        else if animator.type == .Dec
        {
            obj = obj - animator.amount
            if obj < animator.min { obj = animator.max }
        }
        else if animator.type == .Bounce
        {
            if animator.up
            {
                obj = obj + animator.amount
                if obj > animator.max { animator.up = false }
            }
            else
            {
                obj = obj - animator.amount
                if obj < animator.min { animator.up = true }
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
    
    
    func draw()
    {
    }
    
    func animate()
    {
    }
    
}






