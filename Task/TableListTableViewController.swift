//
//  TableListTableViewController.swift
//  Task
//
//  Created by Wesley Austin on 9/28/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit
import CoreData

class TableListTableViewController: UITableViewController, ButtonTableViewCellDelegate, NSFetchedResultsControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        TaskController.sharedController.fetchedResulteController.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table View Data Source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let sections = TaskController.sharedController.fetchedResulteController.sections else { return 1 }
        
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Gets the information of the sections 
        guard let sections = TaskController.sharedController.fetchedResulteController.sections else { return 0 }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as? ButtonTableViewCell,
        let task = TaskController.sharedController.fetchedResulteController.objectAtIndexPath(indexPath) as? Task else { return ButtonTableViewCell() }
        
        cell.updateWithTask(task)
        cell.delegate = self
        
        return cell
    }
 
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Gets the index of the section
        guard let sections = TaskController.sharedController.fetchedResulteController.sections,
            index = Int(sections[section].name) else { return nil }
        
        if index == 0 {
            return "Incomplete Tasks"
        } else {
            return "Complete Tasks"
        }
        
    }

    // MARK: - Button Table View Delegate
    
    func buttonCellButtonTapped(sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPathForCell(sender),
            let task = TaskController.sharedController.fetchedResulteController.objectAtIndexPath(indexPath) as? Task else { return }
        
        TaskController.sharedController.isCompleteValueToggle(task)
     
        sender.updateButton(task.isComplete.boolValue)
    }
    
    // MARK: - NSFetchResultController Delegate 
    
    // Allows updates to happen at the same time
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    // Handles insertion of a section
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    // Handles changing of a Managed Object
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Move:
            guard let indexPath = indexPath,
                newIndexPath = newIndexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    // Ends updates
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail" {
            guard let taskDetailTableViewController = segue.destinationViewController as? TaskDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow,
                let task = TaskController.sharedController.fetchedResulteController.objectAtIndexPath(indexPath) as? Task else { return }
            
            taskDetailTableViewController.task = task
            
        }
    }
 

}
