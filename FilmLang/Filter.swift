//
//  Filter.swift
//  FilmLang
//
//  Created by Robert Dodson on 11/19/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//
// CoreImage filter reference:
//
// https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html
//
// Example js filter definition:  filter:{type:FILTER,name:"CIBoxBlur",inputRadius:80.0},
//

import Foundation
import Cocoa


class Filter
{
    

    static func parseFilter(dict:NSDictionary) -> CIFilter?
    {
        let filterName = dict["name"] as! String
        
        if let filter = CIFilter(name:filterName)
        {
            for key in dict.allKeys
            {
                let strkey = key as! String
                
                if strkey == "type" || strkey == "name"
                {
                    // skip
                }
                else if strkey.uppercased().contains("COLOR")
                {
                    let color = Block.colorFromDict(dict: dict[strkey] as! NSDictionary)
                    filter.setValue(color, forKey:strkey)
                }
                else if strkey.uppercased().contains("POINT")
                {
                    let point = Block.pointFromDict(dict: dict[strkey] as! NSDictionary)
                    let vector = CIVector.init(cgPoint: point)
                    filter.setValue(vector, forKey:strkey)
                }
                else if let val = dict[strkey] as? CGFloat
                {
                    filter.setValue(val, forKey:strkey)
                }
            }
            
            return filter
        }
        
        return nil
       
    }
    
    static func getNSImage(filter:CIFilter,image:CIImage) -> NSImage
    {
        filter.setValue(image, forKey: kCIInputImageKey)
        let rep : NSCIImageRep = NSCIImageRep(ciImage:filter.outputImage!)
        let nsImage: NSImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        
        return nsImage
    }
}
