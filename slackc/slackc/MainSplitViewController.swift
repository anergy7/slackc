//
//  MainSplitViewController.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/2.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa
import Parse

class MainSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
                
    }
    
    override func viewDidAppear() {
        if let channelsVC = splitViewItems[0].viewController as? ChannelsViewController {
            if let chatVC = splitViewItems[1].viewController as? ChatViewController {
                channelsVC.chatVC = chatVC
            }
        }
    
        if var frame = view.window?.frame {
            frame.size = CGSize(width: 1000 , height: 600)
            view.window?.setFrame(frame, display: true, animate: true)
        }
    }

}
