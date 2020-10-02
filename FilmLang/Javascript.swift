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
        
        
        context?.exceptionHandler =
        { context, exception in
            print(exception!.toString()!)
        }
        
        let addBlock: @convention(block) (NSDictionary) -> Void =
        { dict in
            canvas.addBlockFromDictionary(dict: dict)
        }
        context!.setObject(addBlock, forKeyedSubscript: "addBlock" as NSString)
    }

    
    func execScript()
    {
        do
        {
            let url = NSURL.fileURL(withPath: "/Users/robertdodson/Desktop/FILM/FILM.js")
            let scripttorun = try String(contentsOf: url, encoding:.utf8)
            context?.evaluateScript(scripttorun)
        }
        catch
        {
            print("Eval script error: \(error)")
        }
    }
}


