//
//  TaskListTVC.swift
//  UIKitPresented
//
//  Created by Tomas Srna on 26/04/16.
//  Copyright © 2016 SRNA. All rights reserved.
//

import UIKit
import CoreData

class TaskListTVC: UITableViewController, TaskAddDelegate, NSFetchedResultsControllerDelegate {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    // MARK: Core Data
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    lazy var fetchedResultsController : NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "Task")
        let sortDescriptor = NSSortDescriptor(key: "dueDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        _fetchedResultsController.delegate = self
        return _fetchedResultsController
    }()
    
    func refresh() {
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            let alert = UIAlertController(title: "Error Fetching Tasks", message: error.localizedDescription, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sec = sections[section]
            return sec.numberOfObjects
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell")
        let task = fetchedResultsController.objectAtIndexPath(indexPath) as! Task
        cell?.textLabel?.text = task.name
        cell?.detailTextLabel?.text = task.dueDateFormatted
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
        let entityDescription = NSEntityDescription.entityForName("Task", inManagedObjectContext: managedObjectContext)!
        let newTask = Task(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        newTask.name = name
        newTask.dueDate = dueDate
        newTask.done = false
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            let alert = UIAlertController(title: "Error Saving Task", message: error.localizedDescription, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
        refresh()
        tableView.reloadData() // TODO: This is a bad practice
    }
    
}
