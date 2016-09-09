//
//  Task.swift
//  Task
//
//  Created by Wesley Austin on 9/8/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation
import CoreData


class Task: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    static let className = "Task"
    
    convenience init(name: String, notes: String? = nil, dueDate: NSDate? = nil, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entityForName(Task.className, inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = false 
        
    }
}
