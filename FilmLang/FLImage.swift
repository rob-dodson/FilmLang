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
    var context : CIContext?
    
    init(name: String, view: NSView)
    {
        context = CIContext()
        
        super.init(name: name, view: view)
        
        let filters = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
        for filter in filters
        {
            print(filter.description)
        }

    }
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let urlstr = dict["url"]   as? String
        {
            url = URL(string: urlstr)
            
            let filter = CIFilter(name: "CITwirlDistortion")!                         // 2
            //filter.setValue(0.8, forKey: kCIInputIntensityKey)
            let ciimage = CIImage(contentsOf: url!)                           // 3
            filter.setValue(ciimage, forKey: kCIInputImageKey)
            let result = filter.outputImage!                                    // 4
            let cgImage = context!.createCGImage(result, from: result.extent)    // 5
            image = NSImage(cgImage: cgImage!, size: NSSize(width: width, height: height))
        }
    }
    
    override func draw()
    {
        preDraw()
        
        let rect = NSRect(x: x + xoffset, y: y + yoffset, width: width, height: height)

        if image == nil && url != nil
        {
            //image = NSImage.init(byReferencing: url!)
        }
        
        image?.draw(in: rect)
        
        postDraw(rect:nil)
    }
}
