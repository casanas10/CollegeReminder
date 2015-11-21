//
//  SignUpVC.swift
//  College Reminder
//
//  Created by alejandro casanas on 10/28/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var signupActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignUpButtonPressed(sender: AnyObject) {
        
        var error = ""
        
        if usernameTextField.text == "" || passwordTextField.text == "" || emailTextField.text == "" {
            
            
                let uiAlert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(uiAlert, animated: true, completion: nil)
                
                
                uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                    
                }))
            
            
        }
        
        
        if error != "" {
            
            
                let uiAlert = UIAlertController(title: "Error", message: "Try again later", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(uiAlert, animated: true, completion: nil)
                
                
                uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                    
                }))
            
            
        } else {
            
            
            if signupActive == true {
                
                let user = PFUser()
                user.email = emailTextField.text
                user.username = usernameTextField.text
                user.password = passwordTextField.text
                
                
                
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool, signupError: NSError?) -> Void in
                    
                    
                    
                    if signupError == nil  {
                        
                        print("signed up")
                        
                        self.performSegueWithIdentifier("fromSignUpToHome", sender: "self")
                        
                        
                    } else {
                        if let errorString = signupError!.userInfo["error"] as? NSString {
                            
                            error = errorString as String
                            
                        } else {
                            
                            
                                let uiAlert = UIAlertController(title: "Error", message: "Error in form", preferredStyle: UIAlertControllerStyle.Alert)
                                self.presentViewController(uiAlert, animated: true, completion: nil)
                                
                                
                                uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                                    
                                }))
                            
                            
                        }
                        
                        
                            let uiAlert = UIAlertController(title: "Error", message: "Could not sign up, try another email/username", preferredStyle: UIAlertControllerStyle.Alert)
                            self.presentViewController(uiAlert, animated: true, completion: nil)
                            
                            
                            uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                                
                            }))
                        
                        
                    }
                }
                
            }
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
