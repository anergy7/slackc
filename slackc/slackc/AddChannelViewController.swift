//
//  AddChannelViewController.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/2.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa
import Parse

class AddChannelViewController: NSViewController {

    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var descriptionTextField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func addChannelClicked(_ sender: Any) {
        
        let channel = PFObject(className: "Channel")
        channel["title"] = titleTextField.stringValue
        channel["description"] = descriptionTextField.stringValue
        channel.saveInBackground { (success: Bool, error: Error?) in
            if success {
                print("channel created")
                self.view.window?.close()
            } else
            {
                print("Failed")
            }
        }
    }
    
}
