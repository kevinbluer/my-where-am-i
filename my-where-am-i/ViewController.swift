//
//  ViewController.swift
//  my-where-am-i
//
//  Created by Kevin Bluer on 4/25/15.
//  Copyright (c) 2015 Bluer Inc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var manager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // establish location and start the location manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        // set the background color
        var vista: UIView = BackgroundView(frame: CGRectMake(0,0,view.bounds.width,view.bounds.height))
        view.insertSubview(vista, atIndex: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        
        var locationArray = locations as NSArray
        var locationObj = locationArray.lastObject as! CLLocation
        var coord = locationObj.coordinate
        
        var latDelta:CLLocationDegrees = 0.01
        var lngDelta:CLLocationDegrees = 0.01
        
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lngDelta)
        var currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(coord.latitude, coord.longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(currentLocation, theSpan)
        
        self.mapView.setRegion(region, animated: true)
        
        // remove all existing annotations
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        // add new annotation
        var pinLocation = MKPointAnnotation()
        pinLocation.coordinate = currentLocation
        self.mapView.addAnnotation(pinLocation)
    }

    @IBAction func buttonCenterOnMaGIC(sender: AnyObject) {
        manager.stopUpdatingLocation()
        
        var coord = CLLocationCoordinate2D(latitude: 2.909047, longitude: 101.654669)
        
        var latDelta:CLLocationDegrees = 0.01
        var lngDelta:CLLocationDegrees = 0.01
        
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lngDelta)
        var currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(coord.latitude, coord.longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(currentLocation, theSpan)
        
        self.mapView.setRegion(region, animated: true)
        
    }
    

}

