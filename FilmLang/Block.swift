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
    var parent : Block?
    var children : [Block]
    var name: String
    var animateBlock: ((_ obj:Block) -> Void)?
    var x : Double = 0.0
    var y : Double = 0.0
    
    init(name:String,parent:Block?)
    {
        self.name = name
        self.parent = parent
        self.children = [Block]()
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
    
}


class FLRect : Block
{
    var width : Double = 111.0
    var height : Double = 111.0
    var fill : Bool = false
    var strokeWidth : CGFloat = 4
    var fillColor : NSColor = NSColor.darkGray
    var strokeColor : NSColor = NSColor.gray
    var raduis : CGFloat = 7.0
    
    override func draw()
    {
        var xoffset : Double
        var yoffset : Double
        (xoffset,yoffset) = offset()
        let rect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)
        let rectanglePath = NSBezierPath(roundedRect: rect, xRadius: raduis, yRadius: raduis)

        fillColor.setFill()
        rectanglePath.fill()
        strokeColor.setStroke()
        rectanglePath.lineWidth = strokeWidth
        rectanglePath.stroke()
        
        let rectangleStyle = NSMutableParagraphStyle()
        rectangleStyle.alignment = .center
        let rectangleFontAttributes = [
            .font: NSFont(name: "HelveticaNeue", size: 12)!,
            .foregroundColor: NSColor.white,
            .paragraphStyle: rectangleStyle,
        ] as [NSAttributedString.Key: Any]

        name.draw(in: rect.offsetBy(dx: 0, dy: -4), withAttributes: rectangleFontAttributes)
    }
    
}
