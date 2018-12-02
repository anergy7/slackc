//
//  MainWindowController.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/2.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    
    var loginVC : LoginViewController?
    var createAccountVC : CreateAccountViewController?
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        loginVC = contentViewController as? LoginViewController
    }
    
    func moveToCreateAccout() {
        
        if createAccountVC == nil {
            createAccountVC = storyboard?.instantiateController(withIdentifier: "createAccountVC") as? CreateAccountViewController
            }
        window?.contentView = createAccountVC?.view
    }
    
    func moveToLogin() {
//        if let loginVC = storyboard?.instantiateController(withIdentifier: "loginVC") as? LoginViewController {
//        }
        window?.contentView = loginVC?.view

    }
}
