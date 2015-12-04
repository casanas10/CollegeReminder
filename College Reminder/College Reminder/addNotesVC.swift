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

    @IBOutlet weak var sideViewDisplay: UIButton!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
     var object: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideViewDisplay.addTarget(self.revealViewController(), action: Selector("revealToggle:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        if(self.object != nil){
            self.titleField?.text = self.object["title"] as? String
            self.textView?.text = self.object["text"] as? String
            
        }else{
            self.object = PFObject(className: "Notes")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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
    
    
        
    @IBAction func shareToFacebook(sender: UIButton) {
        var shareToFacebook: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        self.presentViewController(shareToFacebook, animated: true, completion: nil)
        shareToFacebook.setInitialText(self.textView?.text)
        
        
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
