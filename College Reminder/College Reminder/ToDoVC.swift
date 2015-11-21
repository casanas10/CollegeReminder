//
//  ToDoVC.swift
//  College Reminder
//
//  Created by alejandro casanas on 11/17/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit

class ToDoVC: UIViewController {

    @IBOutlet weak var sideViewDisplay: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        sideViewDisplay.target = self.revealViewController()
        sideViewDisplay.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
