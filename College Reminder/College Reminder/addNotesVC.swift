//
//  addNotesVC.swift
//  College Reminder
//Created by Anthony Colas on 11/21/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//
import UIKit
import Parse
import Bolts
import Social
import Foundation




class addNotesVC: UIViewController {
    var secondTitle: String!
    var secondText: String!
    @IBOutlet weak var sideViewDisplay: UIButton!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    //@IBOutlet weak var titleField: UITextField!
    //@IBOutlet weak var textView: UITextView!
     var object: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.text = secondTitle
        textView.text = secondText
        sideViewDisplay.addTarget(self.revealViewController(), action: Selector("revealToggle:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    
    @IBAction func saveAction(sender: AnyObject) {
        self.object["username"] = PFUser.currentUser()?.username
        self.object["title"] = self.titleField?.text
        self.object["text"] = self.textView?.text
        
        self.object.saveEventually(){ (success,error) -> Void in
            
            if(error == nil){
                
            }else{
                print(error!.userInfo)
            }
        }

         
        
    
    }
*/
    
    
    @IBAction func shareToFacebook(sender: UIButton) {
        var shareToFacebook: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        self.presentViewController(shareToFacebook, animated: true, completion: nil)
        shareToFacebook.setInitialText(self.textView?.text)
        
        
    }
    
    @IBAction func addNote(sender: UIButton) {
        if textView.text == "" {
            
            let uiAlert = UIAlertController(title: "Error", message: "Please enter a task", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            
            uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                
            }))
            
        } else {
            
            print("test")
            let note_ = PFObject(className: "Notes")
            
            note_["username"] = PFUser.currentUser()?.username
            note_["title"] = titleField!.text
            note_["text"] = textView!.text
            
            
            note_.saveInBackgroundWithBlock {
                (success: Bool, error:NSError?) -> Void in
                
                if(success)
                {
                    //We saved our information
                    //print("Saved")
                    
                    
                    
                    
                    
                    note_.saveInBackgroundWithBlock {
                        (success: Bool, error:NSError?) -> Void in
                        
                        if(success)
                        {
                            //We saved our information
                            print("Success")
                            print("Task added")
                            
                            
                            
                            
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
