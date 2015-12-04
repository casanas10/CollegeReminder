//
//  CalendarViewController.swift
//  College Reminder
//
//  Created by Michael Bentz on 11/21/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import Foundation
import UIKit
import Parse

class CalendarViewController: UIViewController , FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var taskTable: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var sideViewDisplay: UIButton!
    
    // PFObject to hold all tasks for specific days and all events
    var taskArray = [PFObject]()
    var eventArray = [PFObject]()
    var allDays = [Int]()
    var allMonths = [Int]()
    var allYears = [Int]()
    var allTimes = [String]()
    var allDates = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get all events and display on Calendar
        getEvents()
        
        sideViewDisplay.addTarget(self.revealViewController(), action: Selector("revealToggle:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        calendar.scrollDirection = .Horizontal
        calendar.appearance.caseOptions = [.HeaderUsesUpperCase,.WeekdayUsesUpperCase]
        calendar.selectDate(calendar.dateWithYear(2015, month: 10, day: 10))

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /* MARK -- Tableview Functions */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let taskInfo:PFObject = taskArray[indexPath.row] as PFObject
        let cell = taskTable.dequeueReusableCellWithIdentifier("taskCell",forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = String(taskInfo["taskField"]) + " due at \(allTimes[indexPath.row])"
           
        return cell
    }
    
    /* MARK -- Calendar Functions */
    
    func getEvents(){
        let query = PFQuery(className: "ToDoTask")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)

        do {
            eventArray = try query.findObjects()
        } catch {
            print("There was an error")
        }
        
        for i in 0..<eventArray.count{
            let task:PFObject = eventArray[i] as PFObject
            //print("\(task["date"])")
            var formattedDate = task["date"].componentsSeparatedByString("/")
            var timeDate = formattedDate[2].componentsSeparatedByString(",")
            
            let month : String = formattedDate[0]
            let day : String = formattedDate[1]
            let year : String = timeDate[0]
            let time : String = timeDate[1]
            
            var date : String
            
            var newmonth : String
            var newday : String
            var newyear : String
            if Int(month) < 10{
                newmonth = "0" + month
            } else {
                newmonth = month
            }
            if Int(day) < 10{
                newday = "0" + day
            }else{
                newday = day
            }
            newyear = "20" + year
            
            date = newyear + "-" + newmonth + "-" + newday
            
            print(date)
            
            //print("Year: \(year)")
            print("Day: \(day) Month: \(month) Year: \(year)")
            allDays.append(Int(day)!)
            allMonths.append(Int(month)!)
            allYears.append(Int(year)!)
            allTimes.append(time)
            allDates.append(date)
            
            
//            let dateComponents = NSDateComponents()
//            let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
//            dateComponents.setValue(Int(day)!, forComponent: NSCalendarUnit.Day)
//            dateComponents.setValue(Int(month)!, forComponent: NSCalendarUnit.Month)
//            dateComponents.setValue(Int(year)!, forComponent: NSCalendarUnit.Year)
//            let date = calendar?.dateFromComponents(dateComponents)
//            
//            print("Date components: \(date)")
//            allDates.append(date!)
        }
    }
    
    func minimumDateForCalendar(calendar: FSCalendar!) -> NSDate! {
        return calendar.dateWithYear(2015, month: 1, day: 1)
    }
    
    func maximumDateForCalendar(calendar: FSCalendar!) -> NSDate! {
        return calendar.dateWithYear(2016, month: 10, day: 31)
    }
    
    
    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
        //for i in 0..<allDays.count{
         //return
       // }
        var newDate = calendar.stringFromDate(calendar.dateWithYear(calendar.yearOfDate(date), month: calendar.monthOfDate(date), day: calendar.dayOfDate(date)),format:"yyyy-MM-dd") as String
        //print("newdate: " + newDate)
        //print("\(calendar.dateWithYear(calendar.yearOfDate(date), month: 1, day: 5))")
        return allDates.contains(newDate)
        //allDates.contains(String(calendar.dateWithYear(calendar.yearOfDate(date), month: calendar.monthOfDate(date), day: calendar.dayOfDate(date))))
            //(allDays.contains(calendar.dayOfDate(date)) && allMonths.contains(calendar.monthOfDate(date)) && allYears.contains(Int(calendar.stringFromDate(date,format:"yy"))!))
        
    }
    
    func calendarCurrentPageDidChange(calendar: FSCalendar!) {
        NSLog("change page to \(calendar.stringFromDate(calendar.currentPage))")
    }
    
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
        var formattedDate : String
        if (calendar.dayOfDate(date) >= 10){
            formattedDate = calendar.stringFromDate(date, format: "MM/dd/yy")
        } else if (calendar.dayOfDate(date) < 10 && calendar.monthOfDate(date) >= 10){
            formattedDate = calendar.stringFromDate(date,format:"MM/d/yy")
        } else if (calendar.monthOfDate(date) < 10 && calendar.dayOfDate(date) >= 10){
            formattedDate = calendar.stringFromDate(date, format: "M/dd/yy")
        } else {
            formattedDate = calendar.stringFromDate(date, format: "M/d/yy")
        }
        
        print("\(formattedDate)")
        loadTasks(formattedDate)
        NSLog("calendar did select date \(calendar.stringFromDate(date))")
    }
    
    // Load the tasks for a specific day
    // Should check if event exists before searching, use all Arrays as a check
    func loadTasks(date: String){
        let query = PFQuery(className: "ToDoTask")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.whereKey("date", containsString: date)
        do {
            taskArray = try query.findObjects()
        } catch {
            print("There was an error")
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.taskTable.reloadData()
        })
    }
    
//    func calendarCurrentScopeWillChange(calendar: FSCalendar!, animated: Bool) {
//        calendarHeightConstraint.constant = calendar.sizeThatFits(CGSizeZero).height
//        view.layoutIfNeeded()
//    }
//    
//    func calendar(calendar: FSCalendar!, imageForDate date: NSDate!) -> UIImage! {
//        return [13,24].containsObject(calendar.dayOfDate(date)) ? UIImage(named: "🍊") : nil
//    }
    
    @IBAction func toggleCalendar(sender: UIBarButtonItem) {
        if (calendar.scope == .Month){
            self.calendar.setScope(.Week, animated: true)
            sender.title = "➕"
        } else {
            self.calendar.setScope(.Month, animated: true)
            sender.title = "➖"
        }
    }
}