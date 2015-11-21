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
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var timerString: String = ""
    
    var timer = NSTimer()
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    
    var startCount: Bool = true
    
    @IBOutlet weak var startStopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sideViewDisplay.target = self.revealViewController()
        sideViewDisplay.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        timeLabel.text = "00:00.00"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButton(sender: AnyObject) {
        
        if startCount == true {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        
            startStopButton.setTitle("Stop", forState: .Normal)
            
            startCount = false
            
        } else {
            
            timer.invalidate()
            startStopButton.setTitle("Start", forState: .Normal)
            startCount = true
            
        }
        
    }
    
    
    func updateTimer(){
        
        fractions++
        
        if fractions == 100 {
            
            seconds++
            fractions = 0
        }
        
        if seconds == 60 {
            
            minutes++
            seconds = 0
        }
        
        
        let fractionsString = fractions > 9 ? "\(fractions) ":"0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds) " : "0\(seconds)"
        
        let minutesString = minutes > 9 ? "\(minutes) " : "0\(minutes)"
        
        timerString = "\(minutesString):\(secondsString).\(fractionsString)"
        
        timeLabel.text = timerString
        
    }
    

    @IBAction func restartButton(sender: AnyObject) {
        
        minutes = 0
        seconds = 0
        fractions = 0
        
        timerString = "00:00.00"
        timeLabel.text = timerString
    }

    
}