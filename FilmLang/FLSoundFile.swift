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
    var player : AVAudioPlayer?
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let soundfilestr = dict["File"] as? String { soundFilePath = soundfilestr }
    }
    
    
    override func draw()
    {
        if built == false
        {
            if let soundfilepath = soundFilePath
            {
                let url = RFile.makeFilePathURL(rootPath: Javascript.runFolder!.absoluteString, filePath: soundfilepath)
                
                print("Playing sound: \(url)")
                
                do
                {
                    player = try AVAudioPlayer.init(contentsOf: url)
                    
                    if (waitStartSecs > 0)
                    {
                        player?.play(atTime: player!.deviceCurrentTime + waitStartSecs)
                    }
                    else
                    {
                        player!.play()
                    }
                }
                catch
                {
                    print("sound file \(url) failed to load")
                }
               
            }
            
            built = true
        }
        
    }
}
