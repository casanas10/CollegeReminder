//
//  BackTableViewController.swift
//  College Reminder
//
//  Created by Michael Bentz on 10/25/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit
import Parse

var userClasses = [PFObject]()

class RightViewMapController: UITableViewController {

    //var userClasses = [PFObject]()
    var menuArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.tableView?.reloadData()
    }
    
    // MARK: - Table view data sourc
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("userclasses count: " + "\(userClasses.count)")
        return userClasses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let classInfo: PFObject = userClasses[indexPath.row] as PFObject
        //let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "classCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("classCell")! as UITableViewCell
        
        cell.textLabel?.text = String(classInfo["Course_Name"])
        cell.textLabel?.textAlignment = .Right
        print("\(classInfo["Course_Name"])")
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let classSelect: PFObject = userClasses[indexPath.row] as PFObject
        selectedLocation = String(classSelect["Address"])
        selectedLocationName = String(classSelect["Course_Name"])
        print(selectedLocation)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*
        if (segue.identifier == "homeView"){
        let homeVC = segue.destinationViewController as! ViewController
        } else if (segue.identifier == "mapView"){
        let mapVC = segue.destinationViewController as! MapViewController
        }
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        */
    }

    
    func loadClasses(){
        let query = PFQuery(className: "Class")
        query.whereKey("Student", equalTo: PFUser.currentUser()!.username!)
        
        do
        {
            let classArray = try query.findObjects()
            
            userClasses = classArray
            print(userClasses)
            
        }
        catch
        {
            print("There is an error")
        }
    }
    
}
