//
//  CreateAccountViewController.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/2.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa
import Parse

class CreateAccountViewController: NSViewController {

    @IBOutlet weak var loginButton: NSButton!
    @IBOutlet weak var nameTextFieldCreate: NSTextField!
    @IBOutlet weak var emailTextFieldCreate: NSTextField!
    @IBOutlet weak var PasswordTextField: NSSecureTextField!
    @IBOutlet weak var profilePicImageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
//        loginButton.isHidden = true
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    @IBAction func loginClicked(_ sender: Any) {
        print("clicked")
        if let mainWC = view.window?.windowController as? MainWindowController {
            mainWC.moveToLogin()
        }
    }
    
    
    @IBAction func chooseImageClicked(_ sender: Any) {
        
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = true
    }
    
    
    @IBAction func registerClickedCreate(_ sender: Any) {
        let user = PFUser()
        user.email = emailTextFieldCreate.stringValue
        user.password = PasswordTextField.stringValue
        user.username = emailTextFieldCreate.stringValue
        user["name"] = nameTextFieldCreate.stringValue
        user.signUpInBackground {
            (success:Bool, error: Error?) in
            if success {
                print("MAde a USer")
            } else {
                print("We have a problem")
            }
        }
        
    }
}

