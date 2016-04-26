//
//  TaskListTVC.swift
//  UIKitPresented
//
//  Created by Tomas Srna on 26/04/16.
//  Copyright © 2016 SRNA. All rights reserved.
//

import UIKit

class TaskListTVC: UITableViewController, TaskAddDelegate {
    
    var data = [Task]()
    
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell")
        let task = data[indexPath.row]
        cell?.textLabel?.text = task.name
        cell?.detailTextLabel?.text = "\(task.dueDate)"
        return cell!
    }
    
    // MARK: View Controller
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueIdentifier = segue.identifier {
            switch segueIdentifier {
            case "TaskAddSegue":
                if let navigationVC = segue.destinationViewController as? UINavigationController, taskAddVC = navigationVC.topViewController as? TaskAddTVC {
                    taskAddVC.delegate = self
                }
            default: break
            }
        }
    }
    
    // MARK: TaskAddDelegate
    func addTask(name: String, dueDate: NSDate) {
        data.append(Task(name: name, dueDate: dueDate))
        tableView.reloadData()
    }
    
}
