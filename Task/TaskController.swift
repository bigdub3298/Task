//
//  TaskController.swift
//  Task
//
//  Created by Wesley Austin on 8/31/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit
import CoreData

class TaskController {
    
    static let sharedController = TaskController()
    
    var tasks: [Task] {
        return tasksWithPredicate(nil)
    }
    
    var incompleteTasks: [Task] {
        let predicate = NSPredicate(format: "isComplete == FALSE")
        return tasksWithPredicate(predicate)
    }
    
    var completeTasks: [Task] {
        let predicate = NSPredicate(format: "isComplete == TRUE")
        return tasksWithPredicate(predicate)
    }
//    let fetchedResulteController: NSFetchedResultsController
    
    
    init() {
        /*
        let fetchRequest = NSFetchRequest(entityName: Task.className)
        
        let completedSortDescriptor = NSSortDescriptor(key: "isComplete", ascending: true)
        let dueSortDescriptor = NSSortDescriptor(key: "dueDate", ascending: true)
        fetchRequest.sortDescriptors = [completedSortDescriptor, dueSortDescriptor]
        
        self.fetchedResulteController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        do {
            try fetchedResulteController.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch request \(error.localizedDescription)")
        }
    */
    }
 
    
    // Create
    func addTask(task: Task) {
        
        Stack.saveToPersistentStore()
    }
    
    // Remove
    func removeTask(task: Task) {
        task.managedObjectContext?.deleteObject(task)
    }
    
    // Update
    func updateTask(task: Task, name: String, notes: String?, dueDate: NSDate?, isComplete: Bool) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        task.isComplete = isComplete
    }
    
    
    func tasksWithPredicate(predicate: NSPredicate?) -> [Task] {
        let request = NSFetchRequest(entityName: Task.className)
        request.predicate = predicate
        
        let moc = Stack.sharedStack.managedObjectContext
        
        do {
            return try moc.executeFetchRequest(request) as! [Task]
        } catch {
            print("Error loading task. Items not loaded")
            return []
        }
    }
}


