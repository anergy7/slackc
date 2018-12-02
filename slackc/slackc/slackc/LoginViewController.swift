//
//  ViewController.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/2.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {

    @IBOutlet weak var emailTextFieldLoginVC: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func createAccountClicked(_ sender: Any) {
        
        print("registerClicked")
        if let mainWC = view.window?.windowController as? MainWindowController {
            mainWC.moveToCreateAccout()
        }
    }
    
}

