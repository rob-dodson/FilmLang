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
            
            let fullscript = try handleInclude(folder: folder, filestring: scripttorun)
            
           
            
            //
            // execute script
            //
            context?.evaluateScript(fullscript)
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


func handleInclude(folder:URL, filestring:String) throws -> String
{
    let deststring = NSMutableString.init()
    
    let lines = filestring.split(separator: "\n")
    for line in lines
    {
        if  line.contains("includeFile") == true
        {
            let line_str = String(line)
            
            let matches = try line_str.matchRegex(regex: #"includeFile\(\"(.*)\"\)"#)
            
            let match = matches[0]
            if let filematch_range = line_str.rangeFromNSRange(nsRange: match.range(at: 1)) // capture is in 1, full match in 0
            {
                let includefile = String(line_str[filematch_range])
            
                var incpath : URL
                if !includefile.hasPrefix("/")
                {
                    incpath = URL.init(fileURLWithPath:folder.absoluteString)
                    incpath = incpath.appendingPathComponent(includefile)
                }
                else
                {
                    incpath = URL.init(fileURLWithPath:includefile)
                }
                
                print("including: \(incpath)")
                
                var includefilestring = try String(contentsOf:incpath)
                
                includefilestring = try handleInclude(folder: incpath.deletingLastPathComponent(), filestring: includefilestring) // handle further includeFile() calls recursively
                
                deststring.append(includefilestring)
            }
        }
        else
        {
            deststring.append(String(line))
        }
        
        deststring.append("\n")
    }
    
    return deststring as String
}
