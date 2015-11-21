//
//  BackTableViewController.swift
//  College Reminder
//
//  Created by Michael Bentz on 10/25/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit

class BackTableViewController: UITableViewController {

    var menuArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuArray = ["Calendar", "Map", "Timer", "ToDo"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data sourc

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier(menuArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = menuArray[indexPath.row]
        return cell
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

}
