//
//  ViewController.swift
//  College Reminder
//
//  Created by alejandro casanas on 9/25/15.
//  Copyright (c) 2015 alejandro casanas. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var openSideView: UIBarButtonItem!
    
    var varView = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        openSideView.target = self.revealViewController()
        openSideView.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

