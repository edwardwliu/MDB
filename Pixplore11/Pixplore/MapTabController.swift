//
//  MapTabController.swift
//  Pixplore
//
//  Created by Ali Shelton on 4/2/16.
//  Copyright © 2016 Mansi Shah. All rights reserved.
//

import UIKit
import MapKit
import Parse
import CoreLocation


class MapTabController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    //var userLocation = PFGeoPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //geolocation setup
        locationManager.delegate = self
        map.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
        
        self.map.mapType = .Standard
    }
    
    override func viewDidAppear(animated: Bool) {
        findLocations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func findLocations() {
        //Find user location
        var userLocation = PFGeoPoint()
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                userLocation = geoPoint!
                
                /**
                 Run a query for all of the locations in the database within 25 miles of the user's current location and annotate them to the map
                 */
                let locationQuery = PFQuery(className:"Photo")
                print("User location: ", userLocation)
                locationQuery.whereKey("location", nearGeoPoint: userLocation, withinMiles: 25)
                locationQuery.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil {
                        // The find succeeded.
                        if let objects = objects {
                            for object in objects {
                                let photoLocation = object["location"] as! PFGeoPoint
                                let annotation = MKPointAnnotation()
                                annotation.coordinate = CLLocationCoordinate2DMake(photoLocation.latitude, photoLocation.longitude)
                                self.map.addAnnotation(annotation)
                                print("Location Added: ", photoLocation)
                            }
                        }
                    } else {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
