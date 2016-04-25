//
//  FeedViewController.swift
//  Pixplore
//
//  Created by Mansi Shah on 4/2/16.
//  Copyright © 2016 Mansi Shah. All rights reserved.
//

import UIKit
import Parse
import RNFrostedSidebar
import LocationPickerViewController


class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate, RNFrostedSidebarDelegate, LocationPickerDelegate {
    
    //Post variables
    var imageNames = Array<PFFile>()
    var userNames = Array<String>()
    var numSaves = Array<Int>()
    var captions = Array<String>()
    var postObjects = Array<PFObject>()
    var refreshControl = UIRefreshControl()
    var sortbyType = ""
    var currLocation = CLLocation()
    var searchLocation = CLLocation()
    var isUsingCustomLocation = NSUserDefaults.standardUserDefaults().boolForKey("isUsingCustomLocation")
    
    //Cocoa pod variables
    var sideBarImages = NSArray(array: [UIImage(named: "profileIcon")!, UIImage(named: "Door Opened-100")!])
    
    @IBOutlet weak var locationInfo: UINavigationItem!
    @IBOutlet weak var segmentView: UISegmentedControl!
    

    @IBAction func orderbySegmentButton(sender: AnyObject) {
        if segmentView.selectedSegmentIndex == 0 {
            sortbyType = "popular"
        } else {
            sortbyType = "new"
        }
        refresh()
    }
    
    @IBAction func newButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("upload", sender: self)
    }
    
    @IBAction func profileButton(sender: AnyObject) {
        let locationPicker = LocationPicker()
        locationPicker.delegate = self
//        locationPicker.pickCompletion = { (pickedLocationItem) in
//            self.searchLocation = CLLocation(latitude: pickedLocationItem.coordinate.latitude, longitude: pickedLocationItem.coordinate.longitude)
//            print("inside", self.searchLocation)
////            self.collectionView.reloadData()
//            dispatch_async(dispatch_get_main_queue()) {
//               myVars.currLoc = CLLocation(latitude: pickedLocationItem.coordinate.latitude, longitude: pickedLocationItem.coordinate.longitude)
//            }
        
            //self.reloadDataWithLocation(CLLocation(latitude: pickedLocationItem.coordinate.latitude, longitude: pickedLocationItem.coordinate.longitude))
//        }
//        self.collectionView.reloadData()

        print("outside", self.searchLocation)
        locationPicker.addButtons()
        
        navigationController!.pushViewController(locationPicker, animated: true)
    }
    
    func locationDidPick(locationItem: LocationItem) {
        currLocation = CLLocation(latitude: locationItem.coordinate.latitude, longitude: locationItem.coordinate.longitude)
        print("DELEGATE LOCATION: %@", currLocation)
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUsingCustomLocation")
        NSUserDefaults.standardUserDefaults().setDouble(locationItem.coordinate.latitude, forKey: "customLocationLatitude")
        NSUserDefaults.standardUserDefaults().setDouble(locationItem.coordinate.longitude, forKey: "customLocationLongitude")
        NSUserDefaults.standardUserDefaults().synchronize()
//        self.dismissViewControllerAnimated(true, completion: nil)
        self.collectionView.reloadData()
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    func reloadDataWithLocation(location: CLLocation) {
//        self.currLocation = location
//        print("RELOAD LOCATIONZZZ" + location.debugDescription)
//        print("CURR LOCATION RELOAD LOCATIONZZZ" + currLocation.debugDescription)
//        self.collectionView.reloadData()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collection view setup
        collectionView.delegate = self
        collectionView.dataSource = self
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.collectionView?.addSubview(refreshControl)
        orderbySegmentButton(self)
        
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        
        //Grab user location at beginning
        if !isUsingCustomLocation {
            PFGeoPoint.geoPointForCurrentLocationInBackground {
                (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
                if error == nil {
                    let userLoc = geoPoint!
                    //self.currLocation = CLLocation(latitude: userLoc.latitude, longitude: userLoc.longitude)
                    self.currLocation = CLLocation(latitude: userLoc.latitude, longitude: userLoc.longitude)
                }
            }
        }else {
            let locULat = NSUserDefaults.standardUserDefaults().doubleForKey("customLocationLatitude")
            let locULon = NSUserDefaults.standardUserDefaults().doubleForKey("customLocationLongitude")
            if locULon != 0 && locULat != 0 {
                currLocation = CLLocation(latitude:locULat, longitude: locULon)
            }
        }
        
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUsingCustomLocation")
            NSUserDefaults.standardUserDefaults().setDouble(0, forKey: "customLocationLatitude")
            NSUserDefaults.standardUserDefaults().setDouble(0, forKey: "customLocationLongitude")

            NSUserDefaults.standardUserDefaults().synchronize()
        
        //Refresh
        refresh()
    }
    
    override func viewDidAppear(animated: Bool) {
        //set collection view bounds
        collectionView.frame = self.view.bounds
        
        //Swipe right
        let cSelector: Selector = "sideMenu:"
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: cSelector)
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
    }
    
    func refresh() {
        getPosts()
        if self.refreshControl.refreshing {
            self.refreshControl.endRefreshing()
        }
        self.collectionView?.reloadData()
        self.collectionView.setContentOffset(CGPointZero, animated: true)
    }
        
    func getPosts() {
        let query = PFQuery(className: "Photo")
        if (sortbyType == "popular") {
            query.orderByDescending("numberofSaves")
        } else {
            query.orderByDescending("createdAt")
        }
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in

            if error == nil {
                print("Successfully retrieved \(objects!.count) photos.")
                if let objects = objects {
                    self.postObjects = objects
                    self.collectionView.reloadData()
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postObjects.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! FeedCollectionViewCell
        
        postObjects[indexPath.row]["photo"].getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                let tempImage = UIImage(data: imageData!)
                cell.locationImage.image = tempImage
                
                /**
                 Feed information
                 */
                
                //date info
                var date = self.postObjects[indexPath.item].createdAt! as! NSDate
                var currentDate = NSDate()
                var timeBetweenDates = currentDate.timeIntervalSinceDate(date)
                var secondsInADay = 86400.0
                var daysBetween = timeBetweenDates / secondsInADay
                var days = Int(floor(daysBetween))
                if (days == 1) {
                    cell.daysAgoPosted.text = String(days) + " day ago"
                } else {
                    cell.daysAgoPosted.text = String(days) + " days ago"
                }
                
                //geberal feed info
                cell.userName.text = self.postObjects[indexPath.item]["username"] as? String
                cell.numSaves.text = String(self.postObjects[indexPath.item]["numberofSaves"] as! Int) + " Saves"
                cell.caption.text = self.postObjects[indexPath.item]["description"] as? String
                cell.photoObject = self.postObjects[indexPath.row]
                //distance info
                //        var userLocation = PFGeoPoint()
                //        let picLocation = postObjects[indexPath.item]["location"] as! PFGeoPoint
                //        PFGeoPoint.geoPointForCurrentLocationInBackground {
                //            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
                //            if error == nil {
                //                userLocation = geoPoint!
                //                let userLoc:CLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
                //                let picLoc:CLLocation = CLLocation(latitude: picLocation.latitude, longitude: picLocation.longitude)
                //                let dist = userLoc.distanceFromLocation(picLoc)
                //                let inputDist = round(dist*0.00621371)/10
                //                cell.distance.text = String(inputDist) + " Miles"
                //            }
                //        }
                
                print("every index", self.currLocation)
                let picLocation = self.postObjects[indexPath.item]["location"] as! PFGeoPoint
                let picLoc:CLLocation = CLLocation(latitude: picLocation.latitude, longitude: picLocation.longitude)
                let dist = self.currLocation.distanceFromLocation(picLoc)//self.currLocation.distanceFromLocation(picLoc)
                let inputDist = round(dist*0.00621371)/10
                cell.distance.text = String(inputDist) + " Miles"
                
                /**
                 Return cell
                 */
                
            }
            
        }
        return cell
 
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toDetails", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetails" {
            let vc = segue.destinationViewController as! DetailsViewController
            var index = (sender as! NSIndexPath).item
            postObjects[index]["photo"].getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    vc.picture.image = UIImage(data: imageData!)!
                }
            }
            vc.caption = (self.postObjects[index]["description"] as! String)
            vc.userName = (self.postObjects[index]["username"] as! String)
            vc.numSaves = (self.postObjects[index]["numberofSaves"] as! Int)
            var date = postObjects[index].createdAt! as! NSDate
            var currentDate = NSDate()
            var timeBetweenDates = currentDate.timeIntervalSinceDate(date)
            var secondsInADay = 86400.0
            var daysBetween = timeBetweenDates / secondsInADay
            var days = Int(floor(daysBetween))
            vc.days = days as! Int
            //vc.date = (postObjects[index]["createdAt"] as! String)
            vc.location = (self.postObjects[index]["location"] as! PFGeoPoint)
            vc.photoObject = (self.postObjects[index])
//            var userLocation = PFGeoPoint()
//            let picLocation = postObjects[index]["location"] as! PFGeoPoint
//            PFGeoPoint.geoPointForCurrentLocationInBackground {
//                (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
//                if error == nil {
//                    userLocation = geoPoint!
//                    let userLoc:CLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
//                    let picLoc:CLLocation = CLLocation(latitude: picLocation.latitude, longitude: picLocation.longitude)
//                    let dist = userLoc.distanceFromLocation(picLoc)
//                    let inputDist = round(dist*0.00621371)/10
//                    vc.distanceVal = String(inputDist) + " Miles"
//                }
//            }
            let picLocation = postObjects[index]["location"] as! PFGeoPoint
            let picLoc:CLLocation = CLLocation(latitude: picLocation.latitude, longitude: picLocation.longitude)
            let dist = self.currLocation.distanceFromLocation(picLoc)
            let inputDist = round(dist*0.00621371)/10
            vc.distanceVal = String(inputDist) + " Miles"
        }
    }

    /**
     SideMenu functions
     */
    
    func sideMenu(sender: AnyObject) {
        let callout = RNFrostedSidebar(images: self.sideBarImages as! [UIImage])
        callout.delegate = self
        let swipe = sender as! UISwipeGestureRecognizer
        print(swipe.direction)
        if swipe.direction == UISwipeGestureRecognizerDirection.Right {
            callout.show()
        }        
    }
    
    func sidebar(sidebar: RNFrostedSidebar!, didTapItemAtIndex index: UInt) {
        if index == 1 {
            self.performSegueWithIdentifier("locationPick", sender: self)
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
