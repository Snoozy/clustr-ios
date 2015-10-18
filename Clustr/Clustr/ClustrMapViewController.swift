//
//  ClustrMapViewController.swift
//  Clustr
//
//  Created by Wei Lin on 10/17/15.
//  Copyright © 2015 Wei Lin.Inc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ClustrMapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = CLLocationDistance(10)
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(manager.location!.coordinate)
        print(mapView.region.span.latitudeDelta)
    }
    
}
