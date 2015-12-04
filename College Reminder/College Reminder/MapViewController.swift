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
import Parse


var selectedLocation = String()

class MapViewController : UIViewController{
    
    @IBOutlet weak var classTable: UITableView!
    //@IBOutlet weak var mapView: MKMapView!
  
    @IBOutlet weak var openSideView: UIButton!
    @IBOutlet weak var openRightView: UIButton!
    
    //@IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!

    
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
        enableCurrentLocation()
        setupClasses()
        
//        let camera = GMSCameraPosition.cameraWithLatitude(-33.86,
//            longitude: 151.20, zoom: 6)
//        var mapView = GMSMapView.mapWithFrame(CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), camera: camera)
//        //let mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
//        mapView.myLocationEnabled = true
//        self.containerView.addSubview(mapView)
//        self.view.addSubview(containerView)
//        //self.view.addSubview(mapView)
//        
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//        //setupMap()
//        //setupClasses()
        
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
    
    func enableCurrentLocation(){
        if selectedLocation == ""{
            selectedLocation = "Reitz Union Gainesville FL, 32608"
        }
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = selectedLocation
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            //3
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = selectedLocation
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
            
            //Setting up the "deltas". This is the difference in lat and long from one side of the view to another. This basically describes how much we want to zoom
            let latDelta:CLLocationDegrees = 0.01
            let longDelta:CLLocationDegrees = 0.01
            
            //Creating a map region
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            let location = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            //Zoom in on this particular region
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func setupClasses(){
        let query = PFQuery(className: "Class")
        query.whereKey("Student", equalTo: PFUser.currentUser()!.username!)
        
        do
        {
            let classArray = try query.findObjects()
            
            userClasses = classArray
            print(userClasses)
            
        }
        catch
        {
            print("There is an error")
        }
    }
    
    
}