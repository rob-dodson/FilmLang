//
//  Animator.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/23/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation

class Animator
{
    var val : AnimatorVal
    var amount : CGFloat
    var min : CGFloat
    var max : CGFloat
    var type : AnimatorType
    var windowChanged   : ((Animator) -> Void)?
    
    internal init(val: AnimatorVal, amount: CGFloat, min: CGFloat, max: CGFloat, type: Animator.AnimatorType, windowChanged:((Animator?) -> Void)?)
    {
        self.val = val
        self.amount = amount
        self.min = min
        self.max = max
        self.type = type
        self.windowChanged = windowChanged
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
    
