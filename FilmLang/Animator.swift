//
//  Animator.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/23/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class AnimationController : NSObject, CAAnimationDelegate
{
    var animationGoing : Bool = false

    
    func animationDidStart(_ anim: CAAnimation)
    {
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
        animationGoing = false
    }

    func startAnimation(layer:CALayer, property:String, tovalue:Any, fromvalue:Any, duration:CFTimeInterval)
    {
        if animationGoing == false
        {
            animationGoing = true
            
            let anim = CABasicAnimation(keyPath: property)
            anim.toValue = tovalue
            anim.fromValue = fromvalue
            anim.duration = duration
            anim.delegate = self
            
            layer.add(anim, forKey: property)
        }
    }
}


class Animator
{
    /*
    var property : String
    var duration : CGFloat
    var val      : AnimatorVal
    var type     : AnimatorType
    
    */
    
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
        case NOTSET
        case Inc
        case Dec
        case Bounce
    }
    
    enum AnimatorVal
    {
        case NOTSET
        case x
        case y
        case rotation
        case radius
        case startangle
        case endangle
        case fillalpha
        case strokewidth
        case strokealpha
        case scrollamount
        case width
        case height
    }
    
    static func animatorFromDict(dict:NSDictionary) -> Animator
    {
        let val    = dict["value"] as! String
        let amount = CGFloat.init(dict["amount"] as! Double)
        let min    = CGFloat.init(dict["min"] as! Double)
        let max    = CGFloat.init(dict["max"] as! Double)
        let type   = dict["type"] as! String
        
        var value = Animator.AnimatorVal.NOTSET
        if (val == "rotation")    { value = Animator.AnimatorVal.rotation }
        if (val == "x")           { value = Animator.AnimatorVal.x }
        if (val == "y")           { value = Animator.AnimatorVal.y }
        if (val == "startangle")  { value = Animator.AnimatorVal.startangle }
        if (val == "endangle")    { value = Animator.AnimatorVal.endangle }
        if (val == "strokewidth") { value = Animator.AnimatorVal.strokewidth }
        if (val == "strokealpha") { value = Animator.AnimatorVal.strokealpha }
        if (val == "scrollamount"){ value = Animator.AnimatorVal.scrollamount }
        if (val == "width")       { value = Animator.AnimatorVal.width }
        if (val == "height")      { value = Animator.AnimatorVal.height }

        var anitype = Animator.AnimatorType.NOTSET
        if (type == "bounce") { anitype = Animator.AnimatorType.Bounce }
        if (type == "inc")    { anitype = Animator.AnimatorType.Inc }
        if (type == "dec")    { anitype = Animator.AnimatorType.Dec }
    
        return Animator(val: value, amount: amount, min: min, max: max, type: anitype, windowChanged:nil)
    }
    
    static func adjustBlockForAnimation(animator:inout Animator,block:Block)
    {
        switch animator.val
        {
        case .NOTSET:
            print("Animator NOTSET")
            
        case .x:
            print("x")
           //adjust(val:&block.x, animator: &animator)
        
        case.y:
            adjust(val:&block.y, animator: &animator)
            
        case .rotation:
            adjust(val:&block.rotation, animator: &animator)
            
        case .radius:
            adjust(val:&block.radius, animator: &animator)
            
        case .startangle:
            adjust(val:&block.startAngle, animator: &animator)
            
        case .endangle:
            adjust(val:&block.endAngle, animator: &animator)
            
        case .fillalpha:
            if block.fillColor != nil
            {
                var alpha = CGFloat(block.fillColor!.alphaComponent)
                adjust(val:&alpha, animator: &animator)
                block.fillColor = block.fillColor!.withAlphaComponent(CGFloat(alpha))
            }
        case .strokewidth:
            adjust(val:&block.strokeWidth, animator: &animator)
            
        case .strokealpha:
            adjust(val:&block.strokeAlpha, animator: &animator)
            
        case .scrollamount:
            adjust(val:&block.scrollAmount, animator: &animator)
            
        case .width:
            adjust(val:&block.width, animator: &animator)
            
        case .height:
            adjust(val:&block.height, animator: &animator)
        }
    }
    
    static func adjust(val:inout CGFloat,animator:inout Animator)
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
}
    
