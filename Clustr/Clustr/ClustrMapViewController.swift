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
import Alamofire

class ClustrMapViewController: UIViewController, CLLocationManagerDelegate {
    
    private struct Constants {
        static let DestinationRegionRadius:CLLocationDistance = 500
        static let RegionRadius:CLLocationDistance = 1000
        static let DestinationIdentifier = "Destination"
    }

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
        centerMapViewOnLocation(manager.location!)
    }
    
    func centerMapViewOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, Constants.RegionRadius, Constants.RegionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func push(sender: UIButton) {
//       print(mapView.convertPoint(CGPointZero, toCoordinateFromView: mapView))
        let lowerRight = CGPoint(x: self.mapView.bounds.maxX, y: self.mapView.bounds.maxY)
        print("upper left: \(convertPointToMap(CGPointZero))")
        print("lower right: \(convertPointToMap(lowerRight))")
        
    }
    
    func convertPointToMap(point: CGPoint)-> CLLocationCoordinate2D {
        return mapView.convertPoint(point, toCoordinateFromView: mapView)
    }
    
    func pingServer(longitude: Double, latitude: Double, deviceToken: String) -> Void {
        Alamofire.request(.GET, "http://52.88.179.215/ping", parameters: ["latitude" : latitude, "longitude" : longitude, "device_token" : deviceToken])
            .responseJSON { response in
        }
    }
    
    func getMap(topLeftCornerLat: Double, topLeftCornerLong: Double, botRightCornerLat: Double, botRightCornerLong: Double) {
        Alamofire.request(.GET, "http://52.88.179.215/get_map", parameters: ["corner_tl_lat" : topLeftCornerLat, "corner_tl_long" : topLeftCornerLong, "corner_br_lat" : botRightCornerLat, "corner_br_long" : botRightCornerLong])
            .responseJSON { response in
            }
        }
}
