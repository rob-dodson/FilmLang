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


class FLSoundFile : Block
{
    var soundFileURL : String?
    var player : AVAudioPlayer?
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let soundfileurl = dict["URL"]        as? String { soundFileURL = soundfileurl }
    }
    
    
    override func draw()
    {
        if built == false
        {
            if soundFileURL != nil
            {
                let url = URL(fileURLWithPath: soundFileURL!)
                
                do
                {
                    player = try AVAudioPlayer.init(contentsOf: url)
                    player!.play()
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
