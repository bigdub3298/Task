//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Wesley Austin on 8/31/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.primaryLabel.text = task.name

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
 
    
    @IBAction func unwindToTaskListView(sender: UIStoryboardSegue)  {
        if let sourceViewController = sender.sourceViewController as? TaskDetailTableViewController, let task = sourceViewController.task {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let selectedTask = TaskController.sharedController.tasks[selectedIndexPath.row]
                TaskController.sharedController.updateTask(selectedTask, name: task.name, notes: task.notes, dueDate: task.dueDate, isComplete: task.isComplete)
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                let indexPath = NSIndexPath(forItem: TaskController.sharedController.tasks.count, inSection: 0)
                TaskController.sharedController.addTask(task)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Bottom)
            }
        }
    }

}









