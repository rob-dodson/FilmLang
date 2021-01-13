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
        // tell JavascriptCore about our new functions: addBlock(dictionary)
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
            //
            // handle includeFile("path")
            //
            let url = NSURL.fileURL(withPath:path)
            let folder = url.deletingLastPathComponent()
            
            let scripttorun = try String(contentsOf: url)
            let deststring = NSMutableString.init(string: scripttorun)
            
            let re = try NSRegularExpression(pattern: #"includeFile\(\"(.*)\"\)"#, options: .caseInsensitive)
            let matches  = re.matches(in: scripttorun, options: .withoutAnchoringBounds, range:NSMakeRange(0,scripttorun.count))
            
            for match in matches
            {
                let range = match.range(at: 1) // capture is in 1
                let includecmd = match.range(at: 0) // full match in 0
                let file = String(scripttorun.prefix(range.lowerBound + range.length).suffix(range.length)) // get a substring of the file path
                
                var path : URL
                if !file.hasPrefix("/")
                {
                    path = URL.init(fileURLWithPath:folder.absoluteString)
                    path = path.appendingPathComponent(file)
                }
                else
                {
                    path = URL.init(fileURLWithPath:file)
                }
                
                print("including: \(path)")
                
                let includefilestring = try String(contentsOf:path)
                
                re.replaceMatches(in: deststring, options: .withoutAnchoringBounds, range: includecmd, withTemplate: includefilestring)
            }
            
            //
            // execute script
            //
            context?.evaluateScript(deststring as String)
        }
        catch
        {
            print("Eval script error: \(error)")
        }
    }
}


