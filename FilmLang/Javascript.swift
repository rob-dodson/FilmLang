//
//  Javascript.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/23/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import JavaScriptCore
import Cocoa


class Javascript
{
    var context : JSContext?
    var canvas  : Canvas
    
    init(canvas:Canvas)
    {
        self.context = JSContext()
        self.canvas = canvas
        
        
        //
        // Print error from parsing the Javascript
        //
        context?.exceptionHandler =
        { context, exception in
            print(exception!.toString()!)
            print(context!)
        }
        
        //
        // tell JavascriptCore about our new function: addBlock(dictionary)
        //
        let addBlock : @convention(block) (NSDictionary) -> Void =
        { dict in
            Block.addBlockFromDictionary(dict: dict)
        }
        context!.setObject(addBlock, forKeyedSubscript: "addBlock" as NSString)
        
        
    }

    //
    // execute some javascript
    //
    func execScript(path:String)
    {
        do
        {
            let url = NSURL.fileURL(withPath:path)
            let scripttorun = try String(contentsOf: url, encoding:.utf8)
            context?.evaluateScript(scripttorun)
        }
        catch
        {
            print("Eval script error: \(error)")
        }
    }
}


