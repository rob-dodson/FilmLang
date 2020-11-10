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
    var parentView : NSView
    
    init(canvas:Canvas, parentView:NSView)
    {
        self.context = JSContext()
        self.canvas = canvas
        self.parentView = parentView
        
        
        //
        // Print error from parsing the Javascript
        //
        context?.exceptionHandler =
        { context, exception in
            
            let msg = "Error in Javascript: \(exception!.toString()!))"
            print(msg)
            
            Alert.showAlertInWindow(window: parentView.window!,
                                    message: msg,
                info: "",
                ok: {},
                cancel: {})
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


