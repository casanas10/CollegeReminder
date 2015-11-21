//
//  ToDoVC.swift
//  College Reminder
//
//  Created by alejandro casanas on 11/17/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit
import Parse

var dateArr = [String]()
var todoItem = [String]()

class ToDoVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var users = [PFObject]()
    
    @IBOutlet weak var sideViewDisplay: UIBarButtonItem!
    
    @IBOutlet weak var Table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        sideViewDisplay.target = self.revealViewController()
        sideViewDisplay.action = Selector("revealToggle:")
      
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        
        //query users, task, and date
        let query = PFQuery(className: "ToDoTask")
        
        do
        {
            let userArray = try query.findObjects()
            
            users = userArray
            
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let taskInfo: PFObject = users[indexPath.row] as PFObject
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        
        
        
        cell.textLabel?.text = String(taskInfo["taskField"])
        cell.detailTextLabel?.text = String(taskInfo["date"])
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let taskInfo: PFObject = users[indexPath.row] as PFObject
                
        
            taskInfo.deleteInBackground()
            users.removeAtIndex(indexPath.row)
          
            
            
            Table.reloadData()
        }
    }


}
