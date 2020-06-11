//
//  AppDelegate.swift
//  itlwm-client
//
//  Created by gimdh on 2020/06/10.
//  Copyright © 2020 gimdh. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover = NSPopover()
    var available = true

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let ready = open_socket()
                
        var name = "Disconnected"
        
        if ready == 0 {
            name = "NoKext"
            available = false
        }
        
        
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name(name))
        }
        
        constructMenu()
    }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func constructMenu() {
      let menu = NSMenu()
        if available {
            menu.addItem(NSMenuItem(title: "Connect",
                                    action: #selector(join_ssid(_:)),
                                    keyEquivalent: "c"))
        }
        else {
            menu.addItem(NSMenuItem(title: "Driver unavailable. Quit",
                                    action: #selector(quit_action(_:)),
                                    keyEquivalent: "q"))
        }

      menu.addItem(NSMenuItem.separator())

      statusItem.menu = menu
    }
    
    @IBAction func quit_action(_ sender: Any?) {
        exit(0)
    }
    
    @IBAction func join_ssid(_ sender: Any?) {
        let alert = NSAlert()
        alert.messageText = "Connect to AP"
        alert.informativeText = "Provide SSID of the AP and corresponding password if exists"
        alert.alertStyle = .informational
        
        alert.addButton(withTitle: "Connect")
        alert.addButton(withTitle: "Cancel")

        let ssidText = NSTextField(labelWithString: "SSID")
        let ssidField = NSTextField(frame: NSRect(x: 0, y: 0, width: 100, height: 24))
        let passwdText = NSTextField(labelWithString: "Password")
        let passwdField = NSSecureTextField(frame: NSRect(x: 0, y: 0, width: 100, height: 24))
        
        let gridView = NSGridView(views: [[ssidText, ssidField], [passwdText, passwdField]])
        gridView.setFrameSize(NSSize(width: 300, height: 50))
        
        alert.accessoryView = gridView
        
        let response = alert.runModal()
        
        let ssid = ssidField.stringValue
        let passwd = passwdField.stringValue
        
        if response == .alertFirstButtonReturn && ssid != "" {
            let result = send_join_ssid(ssid, passwd)
            
            if result == 0 {
                statusItem.button?.image = NSImage(named:NSImage.Name("Connected"))
            }
        }
    }
}

