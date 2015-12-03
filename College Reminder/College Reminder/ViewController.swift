//
//  ViewController.swift
//  College Reminder
//
//  Created by alejandro casanas on 9/25/15.
//  Copyright (c) 2015 alejandro casanas. All rights reserved.
//

import UIKit
import Parse


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var Label: UILabel!
  
    @IBOutlet weak var openSideView: UIButton!
    
    @IBOutlet weak var Table: UITableView!
    
    var students = [PFObject]()
    
    var varView = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        openSideView.addTarget(self.revealViewController(), action: Selector("revealToggle:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        print(PFUser.currentUser())
        
        if PFUser.currentUser() == nil {
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("goto_signUp", sender: self)
            }
        }
        
        //query users, task, and date
        let query = PFQuery(className: "Class")
        query.whereKey("Student", equalTo: PFUser.currentUser()!.username!)
        
        do
        {
            let userArray = try query.findObjects()
            
            students = userArray
            print(students)
            
        }
        catch
        {
            print("There is an error")
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutButton(sender: AnyObject) {
        
        PFUser.logOut()
        self.performSegueWithIdentifier("HomeToLogin", sender: self)
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let taskInfo: PFObject = students[indexPath.row] as PFObject
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        
        
        
        cell.textLabel?.text = String(taskInfo["Course_Name"])
        cell.detailTextLabel?.text = String(taskInfo["Grade"])
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let taskInfo: PFObject = students[indexPath.row] as PFObject
            
            
            taskInfo.deleteInBackground()
            students.removeAtIndex(indexPath.row)
            
            
            
            Table.reloadData()
        }
    }
    
    

}

