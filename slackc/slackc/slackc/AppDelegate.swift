//
//  AppDelegate.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/2.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa
import Parse

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let config = ParseClientConfiguration { (configThing: ParseMutableClientConfiguration) in
            configThing.applicationId = "slackc"
            configThing.server = "http://slackc.herokuapp.com/parse"
        }
        Parse.initialize(with: config)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

