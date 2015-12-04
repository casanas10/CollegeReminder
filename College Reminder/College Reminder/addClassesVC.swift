//
//  addClassesVC.swift
//  College Reminder
//
//  Created by alejandro casanas on 12/3/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit

class addClassesVC: UIViewController {

    @IBOutlet weak var showSideDisplay: UIButton!
    
    @IBOutlet weak var classNameField: UITextField!
    
    @IBOutlet weak var currentGradeField: UITextField!
    
    @IBOutlet weak var addressClass: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSideDisplay.addTarget(self.revealViewController(), action: Selector("revealToggle:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addClassButton(sender: AnyObject) {
        
        if classNameField.text == "" || currentGradeField.text == "" {
            
            let uiAlert = UIAlertController(title: "Error", message: "Please enter a class name and grade", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            
            uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                
            }))
            
        } else if currentGradeField.text != "A" && currentGradeField.text != "A-" && currentGradeField.text != "B+" && currentGradeField.text != "B" && currentGradeField.text != "B-" && currentGradeField.text != "C+" && currentGradeField.text != "C" && currentGradeField.text != "C-" && currentGradeField.text != "D+" && currentGradeField.text != "D" && currentGradeField.text != "D-" && currentGradeField.text != "F" {
            
            let uiAlert = UIAlertController(title: "Error", message: "Please enter grade between A-F", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            
            uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                
            }))
            
        } else {
            
            
            //add the task to parse
            let classAdd = PFObject(className: "Class")
            
            classAdd["Student"] = PFUser.currentUser()?.username
            classAdd["Course_Name"] = classNameField.text
            classAdd["Grade"] = currentGradeField.text
            classAdd["Address"] = addressClass.text
            
            classAdd.saveInBackgroundWithBlock {
                (success: Bool, error:NSError?) -> Void in
                
                if(success)
                {
                    //We saved our information
                    //print("Saved")
                    
                    
                    
                    
                    
                    classAdd.saveInBackgroundWithBlock {
                        (success: Bool, error:NSError?) -> Void in
                        
                        if(success)
                        {
                            //We saved our information
                            print("Success")
                            print("Class added")
                            
                            self.currentGradeField.text = ""
                            self.classNameField.text = ""
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
        
        
        
    }


    
    //hit return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        classNameField.resignFirstResponder()
        currentGradeField.resignFirstResponder()
        
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
