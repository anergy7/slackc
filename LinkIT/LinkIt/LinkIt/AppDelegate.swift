//
//  AppDelegate.swift
//  LinkIt
//
//  Created by Yiwei.dong on 2018/11/30.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    var item : NSStatusItem? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        item  = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
//        item?.title = "Link IT"
        item?.action = #selector(AppDelegate.linkIt)
    
        item?.image = NSImage(named: "beach")
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Linkit", action: #selector(AppDelegate.linkIt), keyEquivalent: "L"))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quit), keyEquivalent: "Q"))
        item?.menu = menu

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func printPasteBoard() {
        
        if let items = NSPasteboard.general.pasteboardItems {
            for item in items {
                for type in item.types {
                    print("Type:\(type)")
                    print("String:\(String(describing: item.string(forType: type)))")
                }
            }
        }
    }

    @objc func linkIt(){
//        printPasteBoard()
        
        print("We made it")
        if let items = NSPasteboard.general.pasteboardItems {
            for item in items {
                for type in item.types {
                    print(type.rawValue)
                    if type.rawValue == "public.utf8-plain-text" {
                        if let url = item.string(forType: type) {
                            printPasteBoard()
                            print(url)
                            NSPasteboard.general.clearContents()
                            NSPasteboard.general.setString("<a href=\"\(url)\">\(url)</a>", forType: NSPasteboard.PasteboardType(rawValue: "public.html"))
                            
                            NSPasteboard.general.setString(url, forType: NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text"))

                            
                            printPasteBoard()
                        }
                    }
                }
            }
        }

    }
    
    @objc func quit(){
        NSApplication.shared.terminate(self)
        print("We quit it")
    }
}

