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
    
    var profilePicFile : PFFileObject?
    
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
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = ["jpg","png"]
        openPanel.begin { (result) in
            if result == NSApplication.ModalResponse.OK {
                if let imageURL =  openPanel.urls.first {
                    if let image = NSImage(contentsOf: imageURL) {
                        self.profilePicImageView.image = image
                        let imageData = self.jpegDataFrom(image: image)
                        self.profilePicFile = PFFileObject(data: imageData)
                        self.profilePicFile?.saveInBackground()
                    }
                }
            }
        }
    }
    
    func jpegDataFrom(image:NSImage) -> Data {
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])!
        return jpegData
    }
    
    @IBAction func registerClickedCreate(_ sender: Any) {
        PFUser.logOut()
        let user = PFUser()
        user.email = emailTextFieldCreate.stringValue
        user.password = PasswordTextField.stringValue
        user.username = emailTextFieldCreate.stringValue
        user["name"] = nameTextFieldCreate.stringValue
        user["profileImage"] = profilePicFile
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

