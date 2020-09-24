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

@objc protocol RectExport: JSExport
{
    var name   : String { get set }
    var x      : Double { get set }
    var y      : Double { get set }
    var width  : Double { get set }
    var height : Double { get set }

    static func createWith(name:String,x:Double,y:Double,width:Double,height:Double) -> Rect
}

@objc public class Rect : NSObject,RectExport
{
    dynamic var name   : String
    dynamic var x      : Double
    dynamic var y      : Double
    dynamic var width  : Double
    dynamic var height : Double

    required init(name:String,x:Double,y:Double,width:Double,height:Double)
    {
        self.name = name
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }

    class func createWith(name:String,x:Double,y:Double,width:Double,height:Double) -> Rect
    {
        return Rect(name:name,x:x,y:y,width:width,height:height)
    }
}



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
        
        context!.setObject(Rect.self,forKeyedSubscript: "Rect" as NSString)
        
        let addRect: @convention(block) (Rect) -> Void =
        { jsrect in
            
            let r1 = FLRect(name:jsrect.name,view:nil)
            r1.fillColor = NSColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
            r1.strokeColor = NSColor(red: 0.9, green: 0.0, blue: 0.0, alpha: 1.0)
            r1.x = CGFloat(jsrect.x)
            r1.y = CGFloat(jsrect.y)
            r1.width = CGFloat(jsrect.width)
            r1.height = CGFloat(jsrect.height)
            
            canvas.addRect(rect: r1)
        }

        context!.setObject(addRect,
                          forKeyedSubscript: "addRect" as NSString)

        
    }
    
    func execScript()
    {
        do
        {
            let url = NSURL.fileURL(withPath: "/Users/robertdodson/Desktop/FILM.js")
            let scripttorun = try String(contentsOf: url, encoding:.utf8)
            context?.evaluateScript(scripttorun)
        }
        catch
        {
            print("Eval script error: \(error)")
        }
    }
}


/*
- (void) setup
{
 JSContext* context;
    context = [JSContext new];
    KillNow = NO;
    __weak FRGJavascript *wSelf = self;
    FRGJavascript *sSelf = wSelf;
    
    
    [context setExceptionHandler:^(JSContext *context, JSValue *exception)
    {
        [FRGLog msg:@"Javascript error: %@",exception];
        [sSelf->theApp showMessage:[exception toString]];
    }];
    
    
    context[@"playStation"]       = ^(NSString* path,NSString* stationname) { [sSelf playStationAtPath:path withStation:stationname]; };
    context[@"getCurrentStation"] = ^ JSStation* ()             { return [sSelf getCurrentStation]; };
    context[@"sleepInMinutes"]    = ^(double minutes)           { [sSelf sleepInMinutes:minutes];   };
    context[@"waitUntilTime"]     = ^(NSString* timestr)        { [sSelf waitUntilTime:timestr];    };
    context[@"volume"]            = ^(double volume)            { [sSelf volume:volume];            };
    context[@"waitMillis"]        = ^(int millis)               { [sSelf waitMillis:millis];        };
    context[@"volumeMove"]        = ^(double toVol, double inc) { [sSelf volmove:toVol inc:inc];    };
    context[@"play"]              = ^()                         { [sSelf play];                     };
    context[@"pause"]             = ^()                         { [sSelf pause];                    };
    context[@"stop"]              = ^()                         { [sSelf stop];                     };
    context[@"prevStation"]       = ^()                         { [sSelf prevStation];              };
    context[@"nextStation"]       = ^()                         { [sSelf nextStation];              };
}


- (NSError*) runScript:(NSString*)scriptname
{
    NSString* execpath = [NSString stringWithFormat:@"%@/%@",scriptspath,scriptname];
    [FRGLog msg:@"Running script: %@",execpath];
    
    NSURL* url = [NSURL fileURLWithPath:execpath];
    NSError* error = nil;
    NSString* scripttorun = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    KillNow = NO;
    
    if (error == nil)
    {
        running = YES;
        
        [context evaluateScript:scripttorun]; // executes the script
        
        running = NO;
        return nil;
    }
    else
    {
        [FRGLog msg:error.localizedDescription];
        scripterror = [error copy];
        return scripterror;
    }
}
*/
