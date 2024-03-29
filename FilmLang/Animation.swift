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
    var type           : String
    var property       : String!
    var duration       : CGFloat = 1.0
    var autoReverses   : Bool = false
    var repeatDuration : CGFloat = -1
    var repeatCount    : Float = Float.greatestFiniteMagnitude
    var beginTime      : CFTimeInterval = 0
    var max            : CGFloat = 0.0
    var layer          : CALayer!
    var from           : CGFloat?
    var to             : CGFloat?
    var move           : CGPoint?
    var fromColor      : NSColor?
    var toColor        : NSColor?
    var fromPath       : CGPath?
    var toPath         : CGPath?
    var fromPoint      : CGPoint?
    var toPoint        : CGPoint?
    var fromBounds     : CGRect?
    var toBounds       : CGRect?
    
    init(type:String)
    {
        self.type = type
    }
  
    
    static func animationFromDict(type:String,dict:NSDictionary) -> Animation
    {
        let animation = Animation(type:type)
        
        if let property = dict["property"]             as? String  { animation.property = property }
        if let duration = dict["duration"]             as? CGFloat { animation.duration = duration }
        if let autoReverses = dict["autoReverses"]     as? Bool    { animation.autoReverses = autoReverses }
        if let repeatDuration = dict["repeatDuration"] as? CGFloat { animation.repeatDuration = repeatDuration }
        if let repeatCount = dict["repeatCount"]       as? Float   { animation.repeatCount = repeatCount }
        if let beginTime = dict["waitStartSeconds"]    as? CFTimeInterval { animation.beginTime = beginTime }
        if let move = dict["move"]                     as? NSDictionary { animation.move = Block.pointFromDict(dict:move) }
        if let toColor = dict["toColor"]               as? NSDictionary { animation.toColor = Block.colorFromDict(dict:toColor) }
        if let fromColor = dict["fromColor"]           as? NSDictionary { animation.fromColor = Block.colorFromDict(dict:fromColor) }
        if let to = dict["to"]                         as? CGFloat { animation.to = to }
        if let from = dict["from"]                     as? CGFloat { animation.from = from }
        if let max = dict["max"]                       as? CGFloat { animation.max = max }
        if let radius = dict["fromRadius"]             as? CGFloat { animation.from = radius }
        if let radius = dict["toRadius"]               as? CGFloat { animation.to = radius }
        
       
        if animation.property == "size"
        {
            if let size = dict["fromSize"] as? NSDictionary
            {
                let width = size["width"] as? CGFloat ?? 10.0
                let height = size["height"] as? CGFloat ?? 10.0
                animation.fromBounds = CGRect(x: 0, y: 0, width: width, height: height)
            }
            
            if let size = dict["toSize"] as? NSDictionary
            {
                let width = size["width"] as? CGFloat ?? 20.0
                let height = size["height"] as? CGFloat ?? 20.0
                animation.toBounds = CGRect(x: 0, y: 0, width: width, height: height)
            }
            animation.property = "bounds"
        }
              
        if let fromAngles = dict["fromAngles"] as? NSDictionary
        {
            animation.from = fromAngles["start"] as? CGFloat
            animation.to = fromAngles["end"] as? CGFloat
        }
        
        if let toAngles = dict["toAngles"] as? NSDictionary
        {
            animation.from = toAngles["start"] as? CGFloat
            animation.to = toAngles["end"] as? CGFloat
        }
        
        return animation
    }
    
    
    func startAnimation()
    {
        let anim = CABasicAnimation(keyPath:property)
        anim.autoreverses = autoReverses
        anim.duration = CFTimeInterval(duration)
        anim.beginTime = beginTime
        anim.delegate = self
        
        if repeatDuration > 0
        {
            anim.repeatDuration = CFTimeInterval(repeatDuration)
        }
        else if repeatCount > 0
        {
            anim.repeatCount = repeatCount
        }
        
        if type == "ScrollText"
        {
            anim.fromValue = fromPoint
            anim.toValue = toPoint
        }
        else if property == "position"
        {
            anim.fromValue = layer.position
            anim.toValue = CGPoint(x: layer.position.x + move!.x, y: layer.position.y + move!.y)
        }
        else if property == "bounds"
        {
            anim.fromValue = fromBounds
            anim.toValue = toBounds
        }
        else if property == "borderColor" || property == "backgroundColor" || property == "strokeColor" || property == "fillColor"
        {
            anim.fromValue = fromColor?.cgColor
            anim.toValue = toColor?.cgColor
        }
        else if property == "path"
        {
            anim.fromValue = fromPath
            anim.toValue = toPath
        }
        else
        {
            anim.fromValue = from
            anim.toValue = to
        }
        
        if let ourlayer = layer
        {
            ourlayer.add(anim, forKey:property)
        }
        else
        {
            NSLog("attempting to add animation to nil layer: \(type) \(String(describing: property))")
        }
    }
    
    
    func animationDidStart(_ anim: CAAnimation)
    {
    }
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
    }
}

