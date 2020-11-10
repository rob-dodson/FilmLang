//
//  Alert.swift
//  FilmLang
//
//  Created by Robert Dodson on 11/10/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa


class Alert
{
    static func showAlertInWindow(window:NSWindow,
                           message:String,
                           info:String,
                           ok: @escaping () -> Void,
                           cancel: @escaping () -> Void)
    {
        let okcancelalert = NSAlert.init()
        okcancelalert.addButton(withTitle: "Ok")
        okcancelalert.addButton(withTitle: "Cancel")
        okcancelalert.messageText = message
        okcancelalert.informativeText = info
        okcancelalert.alertStyle = .critical
        
        let retval = okcancelalert.runModal()
        if retval == NSApplication.ModalResponse.alertFirstButtonReturn
                  {
                      ok()
                  }
                  else
                  {
                      cancel()
                  }
    }
    
    
    static func showProgressWindow(window:NSWindow,
                           message:String) -> NSAlert
    {
        let alert = NSAlert.init()
        alert.messageText = message
        alert.alertStyle = .informational
        alert.addButton(withTitle: "")
        
        alert.beginSheetModal(for: window)
        { (response) in
        }
        
        return alert
    }
}
