//
//  NotesMasterTableViewController.swift
//  College Reminder
//
//  Created by Anthony Colas on 11/21/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit
import Parse
import Bolts
import Social

class NotesMasterTableViewController: UITableViewController {
    
    var textToShare = ""
    var noteObjects : NSMutableArray!  = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Notes: viewDidLoad")
        
        //allows for white background without showing empty cells if your tableView only has a few items
        let backgroundView = UIView(frame: CGRectZero)
        self.tableView.tableFooterView = backgroundView
        self.tableView.backgroundColor = UIColor.clearColor()
        
        // self.fetchedFromServer = false
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.viewDidAppear(animated)
        
        if (PFUser.currentUser() != nil) {
            fetchAllObjectsFromLocalDatastore()
            fetchAllObjects()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Creates full-width tableViewCell separators. This is required for unpopulated cells.
        if self.tableView.respondsToSelector("setSeparatorInset:") {
            self.tableView.separatorInset = UIEdgeInsetsZero
        }
        
        if self.tableView.respondsToSelector("setLayoutMargins:") {
            self.tableView.layoutMargins = UIEdgeInsetsZero
        }
    }
    
    func fetchAllObjectsFromLocalDatastore(){
        var query: PFQuery = PFQuery(className: "Notes")
        query.fromLocalDatastore()
        
        query.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        query.orderByDescending("createdAt")
        
        
        query.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
            if(error == nil){
                let temp: NSArray = objects! as NSArray
                
                self.noteObjects = temp.mutableCopy() as! NSMutableArray
                
                self.tableView.reloadData()
            }else{
                print(error!.userInfo)
            }
            
        }
    }
    
    func fetchAllObjects(){
        PFObject.unpinAllObjectsInBackgroundWithBlock(nil)
        
        var query: PFQuery = PFQuery(className: "Notes")
        
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
            if(error == nil)
            {
                do{
                    
                    try PFObject.pinAll(objects)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
                
                self.fetchAllObjectsFromLocalDatastore()
            }
            else{
                print(error!.userInfo)
            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.noteObjects.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cellnotes", forIndexPath: indexPath) as! NotesMasterTableViewCell
        
        var object: PFObject = self.noteObjects.objectAtIndex(indexPath.row) as! PFObject
        // Configure the cell...
        
        cell.masterTitleLabel?.text = object["title"] as? String
        cell.masterTextLabel?.text = object["text"] as? String
        
        return cell
    }
    
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            var object:PFObject = self.noteObjects.objectAtIndex(indexPath.row) as! PFObject
            
            object.deleteInBackgroundWithBlock({ (success, error) -> Void in
                
                self.fetchAllObjects()
                
                self.noteObjects.removeObjectAtIndex(indexPath.row)
            })
        }
    }
    
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("editNote", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "editNote") {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let object:PFObject = self.noteObjects.objectAtIndex(indexPath.row) as! PFObject
            let upcoming:AddNoteTableViewController = segue.destinationViewController as! AddNoteTableViewController
            upcoming.object = object
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
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
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}