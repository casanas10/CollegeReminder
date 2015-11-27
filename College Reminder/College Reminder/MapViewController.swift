//
//  MapViewController.swift
//  College Reminder
//
//  Created by Michael Bentz on 10/26/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import Foundation
import MapKit
import GoogleMaps

class MapViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var classTable: UITableView!
    @IBOutlet weak var mapView: MKMapView!
  
    @IBOutlet weak var openSideView: UIButton!
    @IBOutlet weak var openRightView: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
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
        
        let camera = GMSCameraPosition.cameraWithLatitude(-33.86,
            longitude: 151.20, zoom: 6)
        var mapView = GMSMapView.mapWithFrame(CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), camera: camera)
        //let mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
        mapView.myLocationEnabled = true
        self.containerView.addSubview(mapView)
        self.view.addSubview(containerView)
        //self.view.addSubview(mapView)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        //setupMap()
        //setupClasses()
    }
    
    func enableSideMenu(){
        
        openSideView.addTarget(self.revealViewController(), action: Selector("revealToggle:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        openRightView.addTarget(self.revealViewController(), action: Selector("rightRevealToggle:"), forControlEvents: UIControlEvents.TouchUpInside)
        
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