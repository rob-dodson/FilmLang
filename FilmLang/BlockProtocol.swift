//
//  BlockProtocol.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/13/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

protocol BlockProtocol
{
    var name: String { get set }
    var animateBlock: ((_ obj:BlockProtocol) -> Void)? { get set }
}

class FLRect : BlockProtocol
{
    var name : String = "Rect"
    var animateBlock: ((_ obj:BlockProtocol) -> Void)?
    
    var x : Double = 0.0
    var y : Double = 0.0
    var width : Double = 111.0
    var height : Double = 111.0
    var fill : Bool = false
    var strokeWidth : CGFloat = 4
    var fillColor : NSColor = NSColor.darkGray
    var strokeColor : NSColor = NSColor.gray
    var raduis : CGFloat = 7.0
    
    
    init(name:String)
    {
        self.name = name
    }
    
    func draw(offsetX:Double, offsetY:Double)
    {
        let rectanglePath = NSBezierPath(roundedRect: NSRect(x: x + offsetX, y: y + offsetY, width: width, height: height), xRadius: raduis, yRadius: raduis)

        fillColor.setFill()
        rectanglePath.fill()
        strokeColor.setStroke()
        rectanglePath.lineWidth = strokeWidth
        rectanglePath.stroke()
    }
    
}
