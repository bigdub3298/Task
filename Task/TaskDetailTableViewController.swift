//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Wesley Austin on 9/2/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet var toolbar: UIToolbar!
    
    var task: Task?
    var dueDateValue: NSDate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = task {
            updateWithTask(task)
        }
    
        // Disables save button
        saveButton.enabled = false
        
        // Ensures that toolbar is used to finish selections
        nameTextField.inputAccessoryView = toolbar
        dueDateTextField.inputAccessoryView = toolbar
        notesTextView.inputAccessoryView = toolbar
        
        // Makes the date picker the input view of the text field
        dueDateTextField.inputView = dueDatePicker
        
        // Ensures that the due date cannot be set past the current date
        dueDatePicker.minimumDate = NSDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        // Captures information to create new task
        guard let name = nameTextField.text else {return}
        let dueDate = dueDateValue
        let notes = notesTextView.text
        
        // Controls new task vs updating a task
        if let task = self.task {
           TaskController.sharedController.updateTask(task, name: name, notes: notes, dueDate: dueDate)
        } else {
            let newTask = Task(name: name, notes: notes, dueDate: dueDate, context: Stack.sharedStack.managedObjectContext)
            TaskController.sharedController.addTask(newTask)
        }
        
        
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        // Controls how we segue back to main view
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        let isPresentingInAddTaskMode = presentingViewController is UINavigationController
        
        // Controls how we segue back to main view
        if isPresentingInAddTaskMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func cancelToolbarButtonTapped(sender: AnyObject) {
        dueDateTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
        
        // Ensures name text field is not empty
        if nameTextField.text != "" {
            saveButton.enabled = true
        }
    }
 
    @IBAction func doneToolbarButtonTapped(sender: AnyObject) {
        dueDateTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
        
        // Ensures name text field is not empty
        if nameTextField.text != "" {
            saveButton.enabled = true
        }
        
        // Caputes date picker value
        dueDateValue = dueDatePicker.date
    }
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        dueDateTextField.text = dueDateValue?.stringValue()
    }
    
    // MARK: - Helper Functions 
    
    func updateWithTask(task: Task) {
        nameTextField.text = task.name
        dueDateTextField.text = task.dueDate?.stringValue()
        notesTextView.text = task.notes
        navigationBarItem.title = task.name
    }
}
