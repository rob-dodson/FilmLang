//
//  Animation.swift
//  FilmLang
//
//  Created by Robert Dodson on 10/21/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class Animation : NSObject, CAAnimationDelegate
{
    var property       : String!
    var duration       : CGFloat = 1.0
    var autoReverses   : Bool = false
    var repeatDuration : CGFloat = -1
    var repeatCount    : Float = Float.greatestFiniteMagnitude
    var beginTime      : CFTimeInterval = 0
    
    var layer          : CALayer!
    
    var move           : CGPoint?
    var fromColor      : NSColor?
    var toColor        : NSColor?
    var fromSize       : CGFloat?
    var toSize         : CGFloat?
    var fromPath       : CGPath?
    var toPath         : CGPath?
    
    
    static func animationFromDict(dict:NSDictionary) -> Animation
    {
        let animation = Animation()
        
        if let property = dict["property"]             as? String { animation.property = property }
        if let duration = dict["duration"]             as? CGFloat { animation.duration = duration }
        if let autoReverses = dict["autoReverses"]     as? Bool { animation.autoReverses = autoReverses }
        if let repeatDuration = dict["repeatDuration"] as? CGFloat { animation.repeatDuration = repeatDuration }
        if let repeatCount = dict["repeatCount"]       as? Float { animation.repeatCount = repeatCount }
        if let beginTime = dict["beginTime"]           as? CFTimeInterval { animation.beginTime = beginTime }
        
        if let move = dict["move"]                     as? NSDictionary { animation.move = Block.pointFromDict(dict:move) }
        if let toColor = dict["toColor"]               as? NSDictionary { animation.toColor = Block.colorFromDict(dict:toColor) }
        if let fromColor = dict["fromColor"]           as? NSDictionary { animation.fromColor = Block.colorFromDict(dict:fromColor) }
        if let toSize = dict["to"]                     as? CGFloat { animation.toSize = toSize }
        if let fromSize = dict["from"]                 as? CGFloat { animation.fromSize = fromSize }

        return animation
    }
    
    
    func startAnimation()
    {
        let anim = CABasicAnimation(keyPath:property)
        anim.autoreverses = autoReverses
        anim.duration = CFTimeInterval(duration)
        anim.beginTime = beginTime
        
        if repeatDuration > 0
        {
            anim.repeatDuration = CFTimeInterval(repeatDuration)
        }
        else
        {
            anim.repeatCount = repeatCount
        }
        anim.delegate = self
       
        
        if property == "position"
        {
            anim.fromValue = layer.position
            anim.toValue = CGPoint(x: layer.position.x + move!.x, y: layer.position.y + move!.y)
        }
        else if property == "borderColor" || property == "backgroundColor" || property == "strokeColor"
        {
            anim.fromValue = fromColor?.cgColor
            anim.toValue = toColor?.cgColor
        }
        else if property == "borderWidth" || property == "cornerRadius"
        {
            anim.fromValue = fromSize
            anim.toValue = toSize
        }
        else if property == "path"
        {
            anim.fromValue = fromPath
            anim.toValue = toPath
        }
        else
        {
            anim.fromValue = fromSize
            anim.toValue = toSize
        }
        
        layer.add(anim, forKey:property)
    }
    
    
    func animationDidStart(_ anim: CAAnimation)
    {
    }
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
    }
}

