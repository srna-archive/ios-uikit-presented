//
//  TaskAddTVC.swift
//  UIKitPresented
//
//  Created by Tomas Srna on 26/04/16.
//  Copyright © 2016 SRNA. All rights reserved.
//

import UIKit

protocol TaskAddDelegate {
    func addTask(name: String, dueDate: NSDate)
}

class TaskAddTVC: UITableViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var dueDateDP: UIDatePicker!
    
    var delegate: TaskAddDelegate?
    
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true) { 
            self.delegate?.addTask(self.nameTF.text!, dueDate: self.dueDateDP.date)
        }
    }
    
}
