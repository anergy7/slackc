//
//  ChannelsViewController.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/2.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa
import Parse

class ChannelsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var channelTable: NSTableView!
    @IBOutlet weak var profileImageViewSplit: NSImageView!
    @IBOutlet weak var nameLabelSpilt: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        channelTable.dataSource = self
        channelTable.delegate = self
        
    }

    @IBAction func addChannelClicked(_ sender: Any) {
        
        let addChannelWC = storyboard?.instantiateController(withIdentifier: "addChannelVC") as? NSWindowController
        
        addChannelWC?.showWindow(nil)
        
    }
    override func viewDidAppear() {
        if let user = PFUser.current() {
            if let name = user["name"] as? String {
                print(name)
                nameLabelSpilt.stringValue = name
            }
            if let imageFile = user["profileImage"] as? PFFileObject {
                
                imageFile.getDataInBackground { (data: Data?, error: Error?) in
                    if error == nil {
                        if data != nil {
                            let image = NSImage(data: data!)
                            self.profileImageViewSplit.image = image
                        }
                    }
                }
            }
            
        }
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        PFUser.logOut()
        if let mainWC = view.window?.windowController as? MainWindowController {
            mainWC.moveToLogin()
        }
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 40
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "channelCell"), owner: nil) as? NSTableCellView {
            
            cell.textField?.stringValue = "hello"
            return cell
        }
        return nil
    }

}
