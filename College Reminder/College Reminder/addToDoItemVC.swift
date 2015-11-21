//
//  addToDoItemVC.swift
//  College Reminder
//
//  Created by alejandro casanas on 11/21/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit
import Parse

var TODODict = [String: String]()

class addToDoItemVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var sideViewDisplay: UIBarButtonItem!
    
    @IBOutlet weak var taskField: UITextField!
    
    @IBOutlet weak var date: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        sideViewDisplay.target = self.revealViewController()
        sideViewDisplay.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTaskButton(sender: AnyObject) {
    
        if taskField.text == "" {
            
            let uiAlert = UIAlertController(title: "Error", message: "Please enter a task", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            
            uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                
            }))
            
        } else {
           
            //add the task to parse
            let task = PFObject(className: "ToDoTask")
            
            task["username"] = PFUser.currentUser()?.username
            task["taskField"] = taskField!.text
            task["date"] = date!.text
            
            
            task.saveInBackgroundWithBlock {
                (success: Bool, error:NSError?) -> Void in
                
                if(success)
                {
                    //We saved our information
                    //print("Saved")
                    
                    
                    
                    
                    
                    task.saveInBackgroundWithBlock {
                        (success: Bool, error:NSError?) -> Void in
                        
                        if(success)
                        {
                            //We saved our information
                            print("Success")
                            print("Task added")
                            
                            self.taskField.text = ""
                            self.date.text = ""

                            
                        }
                        else
                        {
                            //there was a problem
                            print("Error saving task")
                        }
                        
                    }
                    
                }
                else
                {
                    //there was a problem
                    print("Error saving task")
                }
                
                
            }
            
            
        }
        
        
        dateArr.append(date.text!)
        todoItem.append(taskField.text!)
        
        NSUserDefaults.standardUserDefaults().setObject(dateArr, forKey: "ToDoDate")
        NSUserDefaults.standardUserDefaults().setObject(todoItem, forKey: "ToDoItem")
    
    }
    
    
    //hit return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        taskField.resignFirstResponder()
        date.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
