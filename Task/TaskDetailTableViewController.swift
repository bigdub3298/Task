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
    
        saveButton.enabled = false
        nameTextField.inputAccessoryView = toolbar
        dueDateTextField.inputAccessoryView = toolbar
        dueDateTextField.inputView = dueDatePicker
        dueDatePicker.minimumDate = NSDate()
        notesTextView.inputAccessoryView = toolbar
        dueDatePicker.minimumDate = NSDate() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(sender: AnyObject) {
        guard let name = nameTextField.text else {return}
        let dueDate = dueDateValue
        let notes = notesTextView.text
        
        if let task = self.task {
           TaskController.sharedController.updateTask(task, name: name, notes: notes, dueDate: dueDate)
        } else {
            let newTask = Task(name: name, notes: notes, dueDate: dueDate, context: Stack.sharedStack.managedObjectContext)
            TaskController.sharedController.addTask(newTask)
        }
        
        
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func cancelToolbarButtonTapped(sender: AnyObject) {
        dueDateTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
        
        if nameTextField.text != "" {
            saveButton.enabled = true
        }
    }
 
    @IBAction func doneToolbarButtonTapped(sender: AnyObject) {
        dueDateTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
        
        if nameTextField.text != "" {
            saveButton.enabled = true
        }
        
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
