//
//  FLImage.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/24/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa

import RobToolsLibrary


class FLImage : Block
{
    var url : URL?
    var image : NSImage?
    var ciimage : CIImage!
    var filter : CIFilter?
    
    override init(name: String,type:String)
    {
        super.init(name: name,type:type)
    }
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let urlstr = dict["url"]   as? String
        {
            let url = URL(string:urlstr)
            ciimage = CIImage(contentsOf: url!)
        }
        else if let urlstr = dict["file"]   as? String
        {
            let url = RFile.makeFilePathURL(rootPath: Javascript.runFolder!.absoluteString, filePath: urlstr)
            ciimage = CIImage(contentsOf: url)
        }
        
        if let filterdict = dict["filter"]  as? NSDictionary
        {
            filter = Filter.parseFilter(dict: filterdict)
        }
    }
    
    
    override func draw()
    {
        preDraw()
        
        if built == false
        {
            let layer = newCALayer()
            
            if let filter = filter
            {
                print(filter.inputKeys)
                
                filter.setValue(ciimage, forKey: kCIInputImageKey)
                
                let rep : NSCIImageRep = NSCIImageRep(ciImage:filter.outputImage!)
                let nsImage: NSImage = NSImage(size: rep.size)
                nsImage.addRepresentation(rep)
                layer.contents = nsImage
            }
            else
            {
                let rep : NSCIImageRep = NSCIImageRep(ciImage:ciimage)
                let nsImage: NSImage = NSImage(size: rep.size)
                nsImage.addRepresentation(rep)
                layer.contents = nsImage
            }
            
            layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
            baseLayer.addSublayer(layer)
            Block.addLayerToParent(block: self, layer: baseLayer)
            
            built = true
        }
        
        
        postDraw()
    }
}
