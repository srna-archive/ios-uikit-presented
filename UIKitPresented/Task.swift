//
//  Task.swift
//  UIKitPresented
//
//  Created by Tomas Srna on 26/04/16.
//  Copyright © 2016 SRNA. All rights reserved.
//

import UIKit

class Task {
    var name: String
    var dueDate: NSDate
    var done: Bool
    var image: UIImage?
    
    init(name: String, dueDate: NSDate) {
        self.name = name
        self.dueDate = dueDate
        done = false
        image = nil
    }
}
