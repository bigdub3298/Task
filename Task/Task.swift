//
//  Task.swift
//  Task
//
//  Created by Wesley Austin on 8/31/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class Task: Equatable {
    var name: String
    var dueDate: NSDate?
    var notes: String?
    var isComplete: Bool
    
    init(name: String, notes: String?, dueDate: NSDate?, isComplete: Bool) {
        self.name = name
        self.dueDate = dueDate
        self.notes = notes
        self.isComplete = isComplete
    }
    
}

func ==(lhs: Task, rhs: Task) -> Bool {
    return lhs.name == rhs.name
}
