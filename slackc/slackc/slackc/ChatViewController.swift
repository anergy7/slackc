//
//  ChatViewController.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/2.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa
import Parse

class ChatViewController: NSViewController,NSTableViewDataSource, NSTableViewDelegate {

    var channel : PFObject?
    var chats: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
    }
    
    @IBAction func sendClicked(_ sender: Any) {
        
        if messageBoxTextField.stringValue == "" {
            return
        }
        let chat = PFObject(className: "Chat")
        chat["message"] = messageBoxTextField.stringValue
        chat["user"] = PFUser.current()
        chat["channel"] = channel
        chat.saveInBackground { (success: Bool, error: Error?) in
            if success {
                print("it works in \(String(describing: self.channel))")
                self.messageBoxTextField.stringValue = ""
                
            } else {
                print("cannot send out")
            }
        }
    }
    
    @IBOutlet weak var messageBoxTextField: NSTextFieldCell!
    @IBOutlet weak var chatTableView: NSTableView!
    @IBOutlet weak var channelDescription: NSTextField!
    @IBOutlet weak var topicLabel: NSTextField!

    func getChats() {
        if channel != nil {
            let query = PFQuery(className: "Chat")
            query.whereKey("channel", equalTo: channel!)
            query.addAscendingOrder("createdAt")
            query.findObjectsInBackground { (chats: [PFObject]?, error: Error?) in
                if error == nil {
                    if chats != nil {
                        self.chats = chats!
                    }
                    print("successfully got the data from \(self.channel)")
                    print(chats)
                } else {
                    print("got some problems")
                }
            }
        }
    }
    
    
    
    func updateChannel(channel: PFObject)
    {
        self.channel = channel
        getChats()
        if let title = channel["title"] as? String {
            topicLabel.stringValue = "#\(title)"
            messageBoxTextField.placeholderString = "Message #\(title)"
        }
        if let des = channel["description"] as? String {
            channelDescription.stringValue = des
        }
        chatTableView.reloadData()
        print("reloaded")
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
       return chats.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "chatCell"), owner: nil) as? NSTableCellView  {
            let chat = chats[row]
            if let message = chat["message"] as? String {
                cell.textField?.stringValue = message
            }
            return cell
        }
        return nil
    }
    
}
