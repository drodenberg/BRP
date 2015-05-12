//
//  BRPTableViewController.swift
//  bible
//
//  Created by Daniel Rodenberg on 5/7/15.
//  Copyright (c) 2015 DR. Inc. All rights reserved.
//

import UIKit

class BRPTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var i = 0
        if let filePath = NSBundle.mainBundle().pathForResource("epistles",ofType:"json") {
            if let data = NSData(contentsOfMappedFile: filePath) {
                let json = JSON(data: data, options: NSJSONReadingOptions.AllowFragments, error: nil)
                if let bookArray = json["epistles"]["books"].array {
                    for book in bookArray {
                        var name: String? = book["name"].string
                        if let passagesArray = json["epistles"]["books"][i++]["readings"].array {
                            for passages in passagesArray{
                                var passage: String = passages["passage"].string!
                                readings.append(Readings(name: name, readings: passage))
                            }
                        }
                    }
                }
            }
        }
        
        var longPressd = UILongPressGestureRecognizer(target: self, action: "displayLongPressOptions:")
        
        longPressd.minimumPressDuration = 0.5
        
        tableView.addGestureRecognizer(longPressd)
    }
    
    var readings = [Readings]()

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> BRP {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BRP
        cell.Book.text = readings[indexPath.row].name!
        cell.Chapters.text = readings[indexPath.row].readings!
        cell.Chapters.textAlignment = .Right
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    /*func tableViewCellLongPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began && !tableView.editing {
            let cell = sender.view as! BRP
            
            if let indexPath = tableView.indexPathForCell(cell){
                displayLongPressOptions(cell.self)
            }
        }
    }*/
    
    func displayLongPressOptions(gesture: UILongPressGestureRecognizer) {
        var location = gesture.locationInView(tableView)
        
        var indexPath = tableView.indexPathForRowAtPoint(location)
        
        
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath!) as! BRP
        cell.Book.text = readings[indexPath!.row].name!
        cell.Chapters.text = readings[indexPath!.row].readings!
        cell.Chapters.textAlignment = .Right
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        optionMenu.addAction(UIAlertAction(title: "Mark as Read", style: UIAlertActionStyle.Default, handler: {(action) in
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark}))
        
        optionMenu.addAction(UIAlertAction(title: "Mark as Unread", style: UIAlertActionStyle.Default, handler: {(action) in
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator}))
        
        optionMenu.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
