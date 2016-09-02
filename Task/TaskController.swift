//
//  TaskController.swift
//  Task
//
//  Created by Wesley Austin on 8/31/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class TaskController {
    
    static var sharedController = TaskController()
    
    // Read
    var tasks: [Task]
    
    var mockTasks: [Task] {
        let task1 = Task(name: "Take out the garbage", notes: nil, dueDate: nil, isComplete: false)
        let task2 = Task(name: "Mow the lawn", notes: nil, dueDate: nil, isComplete: false)
        let task3 = Task(name: "Build task view heiarchy", notes: nil, dueDate: nil, isComplete: true)
        
        return [task1, task2, task3]
    }
    
    var completedTasks: [Task] {
        return tasks.filter({$0.isComplete == true})
    }
    
    var incompleteTasks: [Task] {
        return tasks.filter({$0.isComplete == false})
    }
    
    init() {
        tasks = [Task]()
        tasks.appendContentsOf(mockTasks) 
    }
    
    // Create
    func addTask(task: Task) {
        tasks.append(task)
    }
    
    // Update
    func updateTask(task: Task, name: String, notes: String?, dueDate: NSDate?, isComplete: Bool) {
        
        if let index = tasks.indexOf(task) {
            let taskToUpdate = tasks[index]
            taskToUpdate.name = name
            taskToUpdate.isComplete = isComplete
            
            if let notes = notes, let dueDate = dueDate {
                taskToUpdate.notes = notes
                taskToUpdate.dueDate = dueDate
            }
            
            tasks[index] = taskToUpdate
        }
       
    }
    
    // Delete
    func removeTask(task: Task) {
        if let index = tasks.indexOf(task) {
            tasks.removeAtIndex(index)
        }
    }
    
    // Contains 
    func containsTask(task: Task) -> Bool {
        
        for t in tasks {
            if t == task {
                return true
            }
        }
        
        return false
    }
    
}


