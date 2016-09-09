//
//  Task+CoreDataProperties.swift
//  Task
//
//  Created by Wesley Austin on 9/8/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var name: String
    @NSManaged var notes: String?
    @NSManaged var dueDate: NSDate?
    @NSManaged var isComplete: NSNumber

}
