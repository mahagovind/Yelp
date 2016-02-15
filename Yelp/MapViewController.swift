//
//  MapViewController.swift
//  Yelp
//
//  Created by Maha Govindarajan on 2/14/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import MBProgressHUD;

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    var locationManager : CLLocationManager!
      var businesses: [Business]!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
      locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 2000
        locationManager.requestWhenInUseAuthorization()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "An annotation!"
        mapView.addAnnotation(annotation)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        showLoadingHUD()
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: false)
        }
        var addresses : [String] = [String]()
        for (var i = 0 ; i < businesses.count; i++) {
            addresses.append(businesses[i].address!)
        }
        var j = 0

        for (var i = 0 ; i < businesses.count - 1; i++) {
                       var geocoder = CLGeocoder()
            geocoder.geocodeAddressString(addresses[i], completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                if placemarks?[0] != nil {
                    let placemark = placemarks![0]
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = placemark.location!.coordinate
                    annotation.title = self.businesses[j++].name
                    self.mapView.addAnnotation(annotation)
                }
            })
        }
        hideLoadingHUD()
    }
    
    private func showLoadingHUD() {
        let hud = MBProgressHUD.showHUDAddedTo(mapView, animated: true)
        hud.labelText = "Loading..."
    }
    
    private func hideLoadingHUD() {
        MBProgressHUD.hideAllHUDsForView(mapView, animated: true)
    }
    

    @IBAction func onList(sender: AnyObject) {
          dismissViewControllerAnimated(true, completion: nil)
    }
}
