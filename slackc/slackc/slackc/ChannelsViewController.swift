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
    
    var addChannelWC : NSWindowController?
    var channels : [PFObject] = []
    var chatVC : ChatViewController?
    var addChannleViewController : NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        channelTable.dataSource = self
        channelTable.delegate = self
        getChannels()
    }

    @IBAction func addChannelClicked(_ sender: Any) {
        
        addChannelWC = storyboard?.instantiateController(withIdentifier: "addChannelVC") as? NSWindowController
        
//        addChannelWC?.contentViewController
        addChannelWC?.showWindow(nil)
        getChannels()
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
        getChannels()
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        PFUser.logOut()
        if let mainWC = view.window?.windowController as? MainWindowController {
            mainWC.moveToLogin()
        }
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return channels.count
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        if channelTable.selectedRow < 0 {
            
        } else {
            let channel  = channels[channelTable.selectedRow]
//            chatVC?.updateChannel(channel: channel)
            chatVC?.loadChatsAsync(channel: channel)
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let channel = channels[row]
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "channelCell"), owner: nil) as? NSTableCellView {
            
            if let title = channel["title"] as?  String {
                cell.textField?.stringValue = "#\(title)"
                return cell
            }
        }
        return nil
    }
    
    func getChannels(){
        let query = PFQuery(className: "Channel")
        query.order(byAscending: "title")
        query.findObjectsInBackground { (channels: [PFObject]?, error: Error?) in
//            print(channels)
            if channels != nil {
                self.channels = channels!
                self.channelTable.reloadData()
                self.chatVC?.channel = channels![0]
                self.chatVC?.loadChatsAsync(channel: channels![0])
                print("successfully got channels")
            }
            
        }
        
    }

}
