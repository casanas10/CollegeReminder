//
//  ViewController.swift
//  College Reminder
//
//  Created by alejandro casanas on 9/25/15.
//  Copyright (c) 2015 alejandro casanas. All rights reserved.
//

import UIKit
import Parse


class ViewController: UIViewController {

    @IBOutlet weak var Label: UILabel!
  
    @IBOutlet weak var openSideView: UIButton!
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutButton(sender: AnyObject) {
        
        PFUser.logOut()
        self.performSegueWithIdentifier("HomeToLogin", sender: self)
        
        
    }
    
    

}

