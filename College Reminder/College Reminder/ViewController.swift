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
    
    @IBOutlet weak var GPA: UILabel!
    
    
    var sum : Double = 0
    var average : Double = 0
    var students = [PFObject]()
    var className = [String]()
    var grades = [String]()
    
    var pointAverage = [Double]()
    
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
        
        getClass()
        
        
    }
    
    func getClass(){
        
    
        if let user = PFUser.currentUser(){
        //query users, task, and date
        let query = PFQuery(className: "Class")
        query.whereKey("Student", equalTo: PFUser.currentUser()!.username!)
        
        do {
            students = try query.findObjects()
            for user in students {
                
                className.append(String(user["Course_Name"]))
                grades.append(String(user["Grade"]))
            
            
            }
            
        }catch {
            
            print("Something bad happened")
            
        }
        
        let i :String
        
        for i in grades {
            
            switch(i) {
            
            case "A": pointAverage.append(4)
                
                break
                
            case "A-": pointAverage.append(3.7)
                break
                
            case "B+": pointAverage.append(3.3)
                break
                
            case "B": pointAverage.append(3.0)
                break
            
            case "B-": pointAverage.append(2.7)
                break
                
            case "C+": pointAverage.append(2.3)
                break
                
            case "C": pointAverage.append(2.0)
                break
                
            case "C-": pointAverage.append(1.7)
                break
            
            case "D+": pointAverage.append(1.3)
                break
            
            case "D": pointAverage.append(1)
                break
                
            case "D-": pointAverage.append(0.7)
                break
                
            case "F" : pointAverage.append(0.0)
                break
                
            default:
                print("Character not found")
            }
            }
            
        }
        
        //print(pointAverage[0])
        
       
        
        for j in 0..<pointAverage.count {
           
           sum += pointAverage[j]
        }
        
        
        average = (sum / Double(pointAverage.count))
        
        GPA.text = String (average)
        
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
        return className.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        
        
        
        cell.textLabel?.text = className[indexPath.row]
        cell.detailTextLabel?.text = grades[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let taskInfo: PFObject = students[indexPath.row] as PFObject
            
            
            taskInfo.deleteInBackground()
            students.removeAtIndex(indexPath.row)
            className.removeAtIndex(indexPath.row)
            grades.removeAtIndex(indexPath.row)
            
            
            
            Table.reloadData()
        }
    }
    
    

}

