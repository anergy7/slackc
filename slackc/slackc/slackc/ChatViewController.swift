//
//  ChatViewController.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/2.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa
import Parse

class ChatViewController: NSViewController {

    var channel : PFObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func sendClicked(_ sender: Any) {
    }
    
    @IBOutlet weak var messageBoxTextField: NSTextFieldCell!
    
    @IBOutlet weak var chatTableView: NSTableView!
    @IBOutlet weak var channelDescription: NSTextField!
    @IBOutlet weak var topicLabel: NSTextField!

    
    func updateChannel(channel: PFObject)
    {
        self.channel = channel
        if let title = channel["title"] as? String {
            topicLabel.stringValue = title
        }
        if let des = channel["description"] as? String {
            channelDescription.stringValue = des
        }

    }
}
