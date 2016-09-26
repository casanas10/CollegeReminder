//
//  addToDoItemVC.swift
//  College Reminder
//
//  Created by alejandro casanas on 11/21/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit
import Parse
import EventKit


class addToDoItemVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var sideViewDisplay: UIButton!
    
    @IBOutlet weak var taskField: UITextField!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var appDelegate: AppDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sideViewDisplay.addTarget(self.revealViewController(), action: Selector("revealToggle:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        dateLabel.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        
        datePicker.addTarget(self, action: Selector("dateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dateChanged(datePicker:UIDatePicker) {
        
        
        let formatDate = NSDateFormatter()
        formatDate.dateStyle = NSDateFormatterStyle.ShortStyle
        formatDate.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let date_to_string = formatDate.stringFromDate(datePicker.date)
        dateLabel.text = date_to_string
    }
    
    @IBAction func addTaskButton(sender: AnyObject) {
        
        if taskField.text == "" {
            
            let uiAlert = UIAlertController(title: "Error", message: "Please enter a task", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            
            uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                
            }))
            
        } else {
            
            if (dateLabel.text == ""){
                
                dateLabel.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
            }
            
            //add the task to parse
            let task = PFObject(className: "ToDoTask")
            
            task["username"] = PFUser.currentUser()?.username
            task["taskField"] = taskField!.text
            task["date"] = dateLabel!.text
            
            
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
                            //self.dateLabel.text = ""
                            
                            
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
        
        appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        if appDelegate!.eventStore == nil {
            appDelegate!.eventStore = EKEventStore()
            appDelegate!.eventStore!.requestAccessToEntityType(
                EKEntityType.Reminder, completion: {(granted, error) in
                    if !granted {
                         NSOperationQueue.mainQueue().addOperationWithBlock {
                        let uiAlert = UIAlertController(title: "Warning", message: "Task will be added to list, but please grant permission in settings to add to your device's reminders", preferredStyle: UIAlertControllerStyle.Alert)
                        self.presentViewController(uiAlert, animated: true, completion: nil)
                        
                        
                        uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                            
                        }))
                        }
                        print("Access to store not granted")
                        
                        

                        

                        //   print(error!.localizedDescription)
                    } else {
                        print("Access granted")
                    }
            })
        }
        
        if (appDelegate!.eventStore != nil) {
            self.createReminder()
        }
        
        
        
    }
    
    
    func createReminder() {
        
        let reminder = EKReminder(eventStore: appDelegate!.eventStore!)
        
        reminder.title = taskField.text!
        reminder.calendar =
            appDelegate!.eventStore!.defaultCalendarForNewReminders()
        let date = datePicker.date
        let alarm = EKAlarm(absoluteDate: date)
        
        reminder.addAlarm(alarm)
        
        var error: NSError?
        
        
        do{
            try appDelegate!.eventStore!.saveReminder(reminder, commit: true)
        } catch {
            print(error)
        }
        
        if error != nil {
            print("Reminder failed with error \(error?.localizedDescription)")
        }
    }
    
    //hit return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        taskField.resignFirstResponder()
        dateLabel.resignFirstResponder()
        datePicker.resignFirstResponder()
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
