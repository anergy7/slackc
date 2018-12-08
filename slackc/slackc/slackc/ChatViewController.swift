//
//  ChatViewController.swift
//  slackc
//
//  Created by Yiwei.dong on 2018/12/2.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa
import PromiseKit
import Parse

class ChatViewController: NSViewController,NSTableViewDataSource, NSTableViewDelegate {

    var numberOfColumn : Int = 1
    var channel : PFObject?
    var chats: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
    }
    @IBOutlet weak var messageBoxTextField: NSTextField!
    @IBOutlet weak var chatTableView: NSTableView!
    @IBOutlet weak var channelDescription: NSTextField!
    @IBOutlet weak var topicLabel: NSTextField!

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
                self.getChats()
            } else {
                print("cannot send out")
            }
        }
    }
    
//
    func getChats() {
        if channel != nil {
            let query = PFQuery(className: "Chat")
            query.whereKey("channel", equalTo: channel!)
            query.includeKey("user")
            query.addAscendingOrder("createdAt")
            query.findObjectsInBackground { (chats: [PFObject]?, error: Error?) in
                if error == nil {
                    if chats != nil {
                        self.chats = chats!
                        self.chatTableView.reloadData()
                    }
                    print("successfully got the data from \(self.channel)")
                    print(chats)
                } else {
                    print("got some problems")
                }
            }
        }
    }
    
    func getChatsAsync(channel: PFObject) -> Promise<[PFObject]> {
        return Promise { seal in
            self.channel = channel
            let query = PFQuery(className: "Chat")
            query.includeKey("user")
            query.whereKey("channel", equalTo: channel)
            query.addAscendingOrder("createdAt")
            query.findObjectsInBackground { (chats: [PFObject]?, error: Error?) in
                if error == nil {
                    self.chats = chats!
                    self.chatTableView.reloadData()
                    seal.fulfill(chats!)
                } else {
                    seal.reject(error!)
                    print("当前无数据")
                }
            }
        }
    }
    
    func loadChatsAsync(channel: PFObject) {
        firstly {
            return self.getChatsAsync(channel: channel)
            }.done { (onlineChats) in
                self.chats = onlineChats
                if let title = channel["title"] as? String {
                    self.topicLabel.stringValue = "#\(title)"
                    self.messageBoxTextField.placeholderString = "Message #\(title)"
                }
                if let des = channel["description"] as? String {
                    self.channelDescription.stringValue = des
                }
                self.chatTableView.reloadData()
                print("reloaded")
            }.catch { (error) in
                print("dddddddd\(error)")
        }
    }

    
    func updateChatsAsync(channel: PFObject) {
        firstly {
            self.channel = channel
            print("倒计时1秒")
            return after(seconds: 1)
            }
            .then {
                return self.getChatsAsync(channel: channel)
            }.done { (onlineChats) in
                self.chats = onlineChats
                if let title = channel["title"] as? String {
                    self.topicLabel.stringValue = "#\(title)"
                    self.messageBoxTextField.placeholderString = "Message #\(title)"
                }
                if let des = channel["description"] as? String {
                    self.channelDescription.stringValue = des
                }
                self.chatTableView.reloadData()
                print("reloaded")
            }.catch { (error) in
                print("dddddddd\(error)")
        }
    }


//    func getChatsAsync() -> Promise<[PFObject]> {
//        return Promise<Any> { fufill, reject in
//            if channel != nil {
//                let query = PFQuery(className: "Chat")
//                query.whereKey("channel", equalTo: channel!)
//                query.addAscendingOrder("createdAt")
//                query.findObjectsInBackground { (chats: [PFObject]?, error: Error?) in
//                    if error == nil {
//                        if chats != nil {
//                            print("successfully got the data from \(self.channel)")
//                            print(chats)
//                            fufill(chats)
//                        }
//                    } else {
//                        reject(error)
//                    }
//        }
//                    }
//        }
//    }
//
//
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
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "chatCell"), owner: nil) as? ChatCell  {
            let chat = chats[row]
            if let message = chat["message"] as? String {
                cell.messageTextLabel.stringValue = message
                cell.messageTextLabel.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.4)
                cell.messageTextLabel.sizeToFit()
            }
            
            if let user = chat["user"] as? PFUser {
                if let name = user["name"] as? String {
                    cell.userNameLabel.stringValue = name
                }
                if let imageFile = user["profileImage"] as? PFFileObject {
                    imageFile.getDataInBackground { (data: Data?,error: Error?) in
                        if error == nil {
                            if data != nil {
                                let image = NSImage(data: data!)
                                cell.profileImageView.image = image
                            }
                        }
                    }
                }
            }
            
            return cell
        }
        return nil
    }

    
}
