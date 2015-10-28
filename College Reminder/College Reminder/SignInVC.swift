//
//  SignInVC.swift
//  College Reminder
//
//  Created by alejandro casanas on 10/28/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit
import Parse

class SignInVC: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SignInButtonPressed(sender: AnyObject) {
        
        if (usernameTextField.text == "" || passwordTextField.text == "") {
            
            
            
                let uiAlert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(uiAlert, animated: true, completion: nil)
                
                
                uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                    
                }))
            
            
            
        } else {
            
            
            
            PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!, block: { (user, error) -> Void in
                // Stop the activity indicator and make the app usable again
                
                
                if error == nil {
                    
                    print("Logged in Successfully")
                    self.performSegueWithIdentifier("fromSignInToHome", sender: self)
                    
                    
                    
                } else {
                  
                        let uiAlert = UIAlertController(title: "Error", message: "Error login in, incorrect credentials", preferredStyle: UIAlertControllerStyle.Alert)
                        self.presentViewController(uiAlert, animated: true, completion: nil)
                        
                        
                        uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                            
                        }))
                    
                }
            })
        }
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
