//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Wesley Austin on 8/31/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return TaskController.sharedController.tasks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! ButtonTableViewCell
        
        let task = TaskController.sharedController.tasks[indexPath.row]
        
        cell.delegate = self
        cell.updateWithTask(task)

        return cell
    }
 

    func buttonCellButtonTapped(sender: ButtonTableViewCell) {
        
        if let indexPath = tableView.indexPathForCell(sender) {
            let task = TaskController.sharedController.tasks[indexPath.row]
            
            task.isComplete = !task.isComplete.boolValue
            Stack.saveToPersistentStore()
            sender.updateButton(task.isComplete.boolValue)
            
            // Must reload cell instead of entire table view 
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let task = TaskController.sharedController.tasks[indexPath.row]
            TaskController.sharedController.removeTask(task)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail" {
            let taskDetailTableView = segue.destinationViewController as! TaskDetailTableViewController
            
            if let selectedCell = sender as? ButtonTableViewCell, let indexPath = tableView.indexPathForCell(selectedCell) {
                let selectedTask = TaskController.sharedController.tasks[indexPath.row]
                taskDetailTableView.task = selectedTask
            }
        } else if segue.identifier == "addTask" {
            
        }
    }

}









