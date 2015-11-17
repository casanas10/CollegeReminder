//
//  TimerVC.swift
//  College Reminder
//
//  Created by alejandro casanas on 11/17/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit


class TimerVC: UIViewController {

    @IBOutlet weak var sideViewDisplay: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sideViewDisplay.target = self.revealViewController()
        sideViewDisplay.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}