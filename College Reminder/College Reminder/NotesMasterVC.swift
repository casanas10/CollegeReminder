//
//  NotesMasterTableViewController.swift
//  College Reminder
//
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit
import Parse
import Bolts
import Social

class NotesMasterVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var sideViewDisplay: UIButton!

    //@IBOutlet weak var sideViewDisplay: UIButton!
    @IBOutlet weak var Table: UITableView!
    
    var textToShare = ""
    var noteObjects : NSMutableArray!  = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Notes: viewDidLoad")
        
        //allows for white background without showing empty cells if your tableView only has a few items
                
        sideViewDisplay.addTarget(self.revealViewController(), action: Selector("revealToggle:"), forControlEvents: UIControlEvents.TouchUpInside)

        self.navigationController?.setNavigationBarHidden(false, animated: false)

        // Do any additional setup after loading the view.
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
        if Table.respondsToSelector("setSeparatorInset:") {
            self.Table.separatorInset = UIEdgeInsetsZero
            
        }
        
        if Table.respondsToSelector("setLayoutMargins:") {
            self.Table.layoutMargins = UIEdgeInsetsZero
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
                
                self.Table.reloadData()
                
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteObjects.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("cellnotes", forIndexPath: indexPath) as! NotesMasterTableViewCell

        var object: PFObject = self.noteObjects.objectAtIndex(indexPath.row) as! PFObject
        // Configure the cell...
        
        cell.masterTitleLabel?.text = object["title"] as? String
        cell.masterTextLabel?.text = object["text"] as? String
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            var object:PFObject = self.noteObjects.objectAtIndex(indexPath.row) as! PFObject
            
            object.deleteInBackgroundWithBlock({ (success, error) -> Void in
                
                self.fetchAllObjects()
                
                self.noteObjects.removeObjectAtIndex(indexPath.row)
            })
        }
    }


    

   
}
