//
//  ChatCell.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/8.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa

class ChatCell: NSTableCellView {

    @IBOutlet weak var profileImageView: NSImageView!
    @IBOutlet weak var userNameLabel: NSTextField!
    @IBOutlet weak var timeLable: NSTextField!
    @IBOutlet weak var messageTextLabel: NSTextField!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
