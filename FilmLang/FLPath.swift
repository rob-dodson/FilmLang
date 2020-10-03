//
//  FLPath.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/14/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

class FLPath : Block
{
    var points : [NSPoint]
    
    override init(name:String, view:NSView?)
    {
        points = [NSPoint]()
        
        super.init(name: name, view: view)
    }
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        for i in 0...100
        {
            let key = "point\(i)"
            if let dict = dict[key]
            {
                self.points.append(Block.pointFromDict(dict:dict as! NSDictionary))
            }
        }
    }
    
    override func draw()
    {
        preDraw()
        
        let path = NSBezierPath()
        path.lineJoinStyle = .round
        path.move(to: NSPoint(x: xoffset + x, y: yoffset + y))
        for point in points
        {
            path.line(to: NSPoint(x: point.x + xoffset, y: point.y + yoffset))
        }
        
        if let fillcolor = fillColor
        {
            fillcolor.setFill()
            path.fill()
        }
        
        if let strokecolor = strokeColor
        {
            strokecolor.setStroke()
            path.lineWidth = strokeWidth
            path.stroke()
        }
       
        
        postDraw(rect: nil)
    }
}
       
