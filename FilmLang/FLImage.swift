//
//  FLImage.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/24/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

class FLImage : Block
{
    var url : URL?
    var image : NSImage?
    
    override func animate()
    {
        super.animate()
    }
    
    override func draw()
    {
        preDraw()
        
        var xoffset : CGFloat
        var yoffset : CGFloat
        (xoffset,yoffset) = offset()
        
        let rect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)

        if image == nil && url != nil
        {
            image = NSImage.init(byReferencing: url!)
        }
        
        if rotation > -999
        {
            let context = NSGraphicsContext.current!.cgContext
            
            context.translateBy(x:rect.origin.x, y:rect.origin.y)
            context.rotate(by: CGFloat(rotation) * CGFloat.pi/180)
            context.translateBy(x:-rect.origin.x, y:-rect.origin.y)
        }
        
        image?.draw(in: rect)
        
        postDraw(rect:nil)
    }
}
