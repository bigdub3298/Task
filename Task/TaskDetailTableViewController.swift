//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Wesley Austin on 9/2/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var task: Task?
    var dueDateValue: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dueDateTextField.delegate = self
        
        if let task = task {
            updateWithTask(task)
        }
        
        saveButton.enabled = false
        dueDateTextField.inputView = dueDatePicker
        dueDatePicker.minimumDate = NSDate() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Text Field Delegate 
    
    func textFieldDidBeginEditing(textField: UITextField) {
        toolbar.hidden = false
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let dueDate = dueDateValue
            let notes = notesTextView.text ?? ""
            
            task = Task(name: name, notes: notes, dueDate: dueDate)
        }
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        let isPresentingInAddTaskMode = presentingViewController is UINavigationController
        
        if isPresentingInAddTaskMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController?.popViewControllerAnimated(true)
        }
    }
    

    // MARK: - Actions
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        dueDateValue = sender.date
        dueDateTextField.text = dueDateValue?.stringValue()
    }
    
    @IBAction func userTappedView(sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
        saveButton.enabled = true
        toolbar.hidden = true
    }
    
    // MARK: - Helper Functions 
    
    func updateWithTask(task: Task) {
        nameTextField.text = task.name
        dueDateTextField.text = task.dueDate?.stringValue()
        notesTextView.text = task.notes
        navigationBarItem.title = task.name
    }
}
