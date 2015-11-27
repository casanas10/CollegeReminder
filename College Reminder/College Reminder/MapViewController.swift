//
//  MapViewController.swift
//  College Reminder
//
//  Created by Michael Bentz on 10/26/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import Foundation
import MapKit

class MapViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var classTable: UITableView!
    @IBOutlet weak var mapView: MKMapView!
  
    @IBOutlet weak var openSideView: UIButton!
    
    var classes = [String]()
    
    struct task {
        var description: String
        var day : Int
        var month: Int
        var year : Int
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableSideMenu()
        setupMap()
        setupClasses()
    }
    
    func enableSideMenu(){
        
        openSideView.addTarget(self.revealViewController(), action: Selector("revealToggle:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupMap(){
        let location = CLLocationCoordinate2DMake(29.665245, -82.336097)
        let span = MKCoordinateSpanMake(0.002, 0.002)
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "University of Florida"
        
        mapView.addAnnotation(annotation)
    }
    
    func setupClasses(){
        classes = ["Operating Systems", "Software Engineering","iOS Development", "Integrated Product & Process Design"]
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = classTable.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = classes[indexPath.row]
        return cell
    }
}