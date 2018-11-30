//
//  ViewController.swift
//  FirstToDo
//
//  Created by Yiwei.dong on 2018/11/29.
//  Copyright © 2018年 yw. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    
    @IBOutlet weak var tableView: NSTableView!
    
    
    var todoItems : [ToDoItem] = []
    @IBOutlet weak var addButton: NSButton!
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var importanceCheckBox: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getTodoItems()


        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func getTodoItems()
    {
        // Get the todoItems from coredata
        
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

            do {
                todoItems = try context.fetch(ToDoItem.fetchRequest())
                print(todoItems.count)
            } catch {
            }
        }
        tableView.reloadData()
        //set them to the class
    }
    
    
    @IBOutlet weak var tableHeader: NSTableHeaderView!
    @IBAction func addButtonClicked(_ sender: Any) {
        
        if textField.stringValue != "" {
            if let context  = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let toDoItem = ToDoItem(context: context)
                toDoItem.name = textField.stringValue
                if importanceCheckBox.state.rawValue == 0 {
                    toDoItem.importance = true
                }else {
                    toDoItem.importance = false
                }
                
                (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
                
                textField.stringValue = ""
                importanceCheckBox.state = NSControl.StateValue(rawValue: 0)
            }
            getTodoItems()

        } else {return}
            
    }
    
    // MARK: - TableView Codes
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let toDoItem = todoItems[row]

        if (tableColumn?.identifier)!.rawValue == "importantColumn" {
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "importantCell"), owner: self) as? NSTableCellView {
                
                if toDoItem.importance == true {
                    cell.textField?.stringValue = "!"
                } else
                {
                    cell.textField?.stringValue = "_"
                    
                }
                return cell
            }
        } else {
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "importantCell"), owner: self) as? NSTableCellView {
                cell.textField?.stringValue = toDoItem.name!
                return cell
            }
        
        }

        return nil
    }
}
