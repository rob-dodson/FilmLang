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
            var fileName : String!
            
            let arguments = CommandLine.arguments
            
            var count = 0
            for arg in arguments
            {
                if arg == "--fullscreen"
                {
                    window.toggleFullScreen(nil)
                }
                else if arg == "--file"
                {
                    fileName = CommandLine.arguments[count + 1]
                }
                
                count = count + 1
            }
            
            if let file = fileName
            {
                DispatchQueue.main.async
                {
                    self.canvas.clear()
                    self.canvas.run(path:file)
                }
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
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool
    {
        return true
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool
    {
        return true
    }
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply
    {
        return NSApplication.TerminateReply.terminateNow
    }
}

