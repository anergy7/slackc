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

    @IBOutlet weak var registerButton: NSButton!
    @IBOutlet weak var passwordTextFieldLoginVC: NSSecureTextField!
    @IBOutlet weak var emailTextFieldLoginVC: NSTextField!
    @IBOutlet weak var loginButtonLoginVC: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + .nanoseconds(50)) {
            if var frame = self.view.window?.frame {
                frame.size = CGSize(width: 480, height: 300)
                self.view.window?.setFrame(frame, display: true, animate: true)
            }
            
        }

    }

    override func viewDidAppear() {
        if var frame = view.window?.frame {
            frame.size = CGSize(width: 480, height: 300)
            view.window?.setFrame(frame, display: true, animate: true)
        }
    }

    
    @IBAction func loginClickedLoginVC(_ sender: Any) {
        registerButton.isEnabled = false
        loginButtonLoginVC.isEnabled = false
        PFUser.logInWithUsername(inBackground: emailTextFieldLoginVC.stringValue, password: passwordTextFieldLoginVC.stringValue) { (user: PFUser?, error: Error?) in
            if error == nil {
                print("You login")
                if let mainWC = self.view.window?.windowController as? MainWindowController {
                    self.loginButtonLoginVC.isEnabled = true
                    self.registerButton.isEnabled = true

                    mainWC.moveToChat()
                }
            } else {
                self.loginButtonLoginVC.isEnabled = true
                self.registerButton.isEnabled = true
                let answer = self.dialogOKCancel(question: "登陆失败", text: "请重试")
                
                print("login failed")
            }
        }
    }
    
    // 生成带OKCancel的Dialogue
    func dialogOKCancel(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
//        alert.addButton(withTitle: "Cancel")
        return alert.runModal() == .alertFirstButtonReturn
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

