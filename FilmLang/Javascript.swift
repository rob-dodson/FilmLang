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

import RobToolsLibrary

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
            
            RAlert.showAlertInWindow(window: parentView.window!,
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
            let matches  = re.matches(in: scripttorun, options:[], range: NSMakeRange(0,scripttorun.count))
            
            for match in matches
            {
                let includefilecmd_nsrange : NSRange = match.range(at: 0) // full match in 0
                
                if let filematch_range = scripttorun.rangeFromNSRange(nsRange: match.range(at: 1)) // capture is in 1
                {
                    let filename = String(scripttorun[filematch_range])
                    
                    var incpath : URL
                    if !filename.hasPrefix("/")
                    {
                        incpath = URL.init(fileURLWithPath:folder.absoluteString)
                        incpath = incpath.appendingPathComponent(filename)
                    }
                    else
                    {
                        incpath = URL.init(fileURLWithPath:filename)
                    }
                    
                    print("including: \(incpath)")
                    
                    let includefilestring = try String(contentsOf:incpath)
                    
                    re.replaceMatches(in: deststring, options:[], range: includefilecmd_nsrange, withTemplate: includefilestring)
                }
            }
            
            //
            // execute script
            //
            context?.evaluateScript(deststring as String)
        }
        catch
        {
            let msg = "Eval script error: \(error)"
            
            RAlert.showAlertInWindow(window: parentView.window!,
                                    message: msg,
                info: "",
                ok: {},
                cancel: {})
            
            
        }
    }
}


