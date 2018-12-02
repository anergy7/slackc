//
//  ChatViewController.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/2.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa

class ChatViewController: NSViewController {

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

}
