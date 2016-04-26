//
//  Task.swift
//  UIKitPresented
//
//  Created by Tomas Srna on 26/04/16.
//  Copyright © 2016 SRNA. All rights reserved.
//

import UIKit
import CoreData

class Task: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var dueDate: NSDate
    @NSManaged var done: Bool
    
    var dueDateFormatted : String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .NoStyle
        return dateFormatter.stringFromDate(dueDate)
    }
}
