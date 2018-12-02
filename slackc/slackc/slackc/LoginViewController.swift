//
//  ViewController.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/2.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa
import Parse

class LoginViewController: NSViewController,NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var passwordTextFieldLoginVC: NSSecureTextField!
    @IBOutlet weak var emailTextFieldLoginVC: NSTextField!
    @IBOutlet weak var loginButtonLoginVC: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginClickedLoginVC(_ sender: Any) {
        
        loginButtonLoginVC.isEnabled = false
        PFUser.logInWithUsername(inBackground: emailTextFieldLoginVC.stringValue, password: passwordTextFieldLoginVC.stringValue) { (user: PFUser?, error: Error?) in
            if error == nil {
                print("You login")
                if let mainWC = self.view.window?.windowController as? MainWindowController {
                    self.loginButtonLoginVC.isEnabled = true
                    mainWC.moveToChat()
                    
                }
            } else {
                self.loginButtonLoginVC.isEnabled = true
                print("login failed")
            }
        }
    }
    
    // 判断是否为email地址
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
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

