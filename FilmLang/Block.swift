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
    var x : Double = 10.0
    var y : Double = 10.0
    
    
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






