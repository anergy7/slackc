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

    @objc func linkIt(){
        print("We made it")
    }
    
    @objc func quit(){
        NSApplication.shared.terminate(self)
        print("We quit it")
    }
}

