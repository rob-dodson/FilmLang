//
//  AppDelegate.swift
//  FilmLang
//
//  Created by Robert Dodson on 9/9/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Cocoa

import RobToolsLibrary


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var canvas: Canvas!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        self.pickFile(ignoreCmdLine: false)
    }

    @IBAction func openFileAction(_ sender: Any)
    {
        self.pickFile(ignoreCmdLine: true)
    }
    
    
    func pickFile(ignoreCmdLine:Bool)
    {
        if ignoreCmdLine == false
        {
            let arguments = CommandLine.arguments
            
            var count = 0
            for arg in arguments
            {
                if arg == "--file"
                {
                    let file = CommandLine.arguments[count + 1]
                    
                    DispatchQueue.main.async
                    {
                        self.canvas.clear()
                        self.canvas.run(path:file)
                    }
                    
                    return
                }
                count = count + 1
            }
        }
        else
        {
            RFile.pickfile(title:"Open a FilmLang js file.",folders:false,startfolder:"~/Desktop", defaultsname: "FilmLang")
            { (keyfile) in
                
                DispatchQueue.main.async
                {
                    self.canvas.clear()
                    self.canvas.run(path:keyfile)
                }
            }
        }
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification)
    {
        NSLog("here")
    }

    private func applicationShouldTerminateAfterLastWindowClosed(app:NSApplication) -> Bool
    {
        return true
    }
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply
    {
        return NSApplication.TerminateReply.terminateNow
    }

    internal func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool
    {
        if (flag)
        {
            return false
        }
        else
        {
            window.makeKeyAndOrderFront(self)
            return true
        }
    }

    
    
    
    
   

}

