//
//  FLSoundFile.swift
//  FilmLang
//
//  Created by Robert Dodson on 1/22/21.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa
import AVFoundation

import RobToolsLibrary

class FLSoundFile : Block
{
    var soundFilePath : String?
    var soundUrl : URL?
    var player   : AVAudioPlayer?
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let soundfilestr = dict["File"] as? String { soundFilePath = soundfilestr }
    }
    
    
    override func draw()
    {
        preDraw()
        
        if built == false
        {
            if let soundfilepath = soundFilePath
            {
                soundUrl = RFile.makeFilePathURL(rootPath: Javascript.runFolder!.absoluteString, filePath: soundfilepath)
            }
            
            built = true
        }
        
        postDraw()
    }
    
    override func start()
    {
        do
        {
            if let url = soundUrl
            {
                print("Playing sound: \(url)")
                player = try AVAudioPlayer.init(contentsOf: url)
                if let player = self.player
                {
                    player.play()
                }
            }
        }
        catch
        {
                print("error playing sound")
        }
    }
}
