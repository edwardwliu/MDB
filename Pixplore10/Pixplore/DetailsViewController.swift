//
//  DetailsViewController.swift
//  Pixplore
//
//  Created by Ali Shelton on 4/3/16.
//  Copyright © 2016 Mansi Shah. All rights reserved.
//

import UIKit
import MapKit
import Parse

class DetailsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //Passed in variables
    var image = UIImage()
    var userName = ""
    var numSaves = 0
    var created = ""
    var location = PFGeoPoint()
    var caption = ""
    var photoObject: PFObject?

    //Location
    let locationManager = CLLocationManager()
    
    //Connections to storyboard
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet var navigationIcon: UIImageView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet var username: UILabel!
    
    @IBOutlet var saves: UILabel!
    @IBOutlet var createdCaption: UILabel!
    
    
    //Functions
    @IBAction func navigate(sender: AnyObject) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(self.location.latitude, self.location.longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "hi"
        mapItem.openInMapsWithLaunchOptions(options)
    }
    
    @IBAction func openOnMap(sender: AnyObject) {
        
    }
    
    @IBAction func savePressed(sender: AnyObject) {
        let currentUser = PFUser.currentUser()
        if (!currentUser!["savedImages"].containsObject(photoObject!)) {
            numSaves = photoObject!["numberofSaves"] as! Int + 1
            photoObject!["numberofSaves"] = numSaves
            currentUser?.addUniqueObject(photoObject!, forKey: "savedImages")
            currentUser?.saveInBackgroundWithTarget(nil, selector: nil)
            if (currentUser!["savedImages"] == nil) {
                self.saves.text = String(self.numSaves) + " Save"
            }
            else {
                self.saves.text = String(self.numSaves) + " Saves"
            }
        }
    }
    
    @IBAction func backFromDetails(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        self.picture.image = self.image
        self.username.text = self.userName
        self.saves.text = String(self.numSaves) + " Saves"
        self.createdCaption.text = self.caption
        //self.date = created
        //self.saves.text = String(self.numSaves)
        //self.distance = something with location
        self.map.mapType = .Standard
        
        //location
        locationManager.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        addAnnotation()
        centerLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAnnotation() {
        var photoLocation = photoObject!["location"]
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(photoLocation.latitude, photoLocation.longitude)
        self.map.addAnnotation(annotation)
        print("Location Added: ", photoLocation)
    }
    
    func centerLocation() {
        var location = CLLocationCoordinate2D(latitude: self.location.latitude, longitude: self.location.longitude)
        let span = MKCoordinateSpanMake(10, 10)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: false)
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
