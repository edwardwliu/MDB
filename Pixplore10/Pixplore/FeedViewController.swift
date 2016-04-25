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

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate, RNFrostedSidebarDelegate {
    
    //Post variables
    var imageNames = Array<PFFile>()
    var userNames = Array<String>()
    var numSaves = Array<Int>()
    var captions = Array<String>()
    var postObjects = Array<PFObject>()
    var refreshControl = UIRefreshControl()
    var sortbyType = "popular"
    
    //Cocoa pod variables
    var sideBarImages = NSArray(array: [UIImage(named: "profileIcon")!, UIImage(named: "Door Opened-100")!])
    
    @IBOutlet var newPressed: UIButton!
    @IBOutlet weak var segmentView: UISegmentedControl!

    @IBAction func orderbySegmentButton(sender: AnyObject) {
        if segmentView.selectedSegmentIndex == 0 {
            sortbyType = "popular"
        } else {
            sortbyType = "new"
        }
        refresh(self)
    }
    
    @IBAction func newButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("upload", sender: self)
    }
    
    @IBAction func profileButton(sender: AnyObject) {
        let callout = RNFrostedSidebar(images: self.sideBarImages as! [UIImage])
        callout.delegate = self
        callout.show()
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collection view setup
        collectionView.delegate = self
        collectionView.dataSource = self
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.collectionView?.addSubview(refreshControl)
        refresh(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        //Load posts in
        getPosts()
        
        //set collection view bounds
        collectionView.frame = self.view.bounds
        
        let cSelector: Selector = "sideMenu:"
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: cSelector)
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
    }
    
    func refresh(sender: AnyObject) {
        self.refreshFeed()
        self.collectionView.setContentOffset(CGPointZero, animated: true)
    }
    
    func refreshFeed() {
        getPosts()
        if self.refreshControl.refreshing {
            self.refreshControl.endRefreshing()
        }
        self.collectionView?.reloadData()
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
            }
        }
        
        cell.userName.text = postObjects[indexPath.item]["username"] as! String
        cell.numSaves.text = String(postObjects[indexPath.item]["numberofSaves"] as! Int) + " Saves"
        cell.caption.text = postObjects[indexPath.item]["description"] as! String
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
            //vc.date = (postObjects[index]["createdAt"] as! String)
            vc.location = (self.postObjects[index]["location"] as! PFGeoPoint)
            vc.photoObject = (self.postObjects[index])
            
        }
    }
    
    func sideMenu(sender: AnyObject) {
        let callout = RNFrostedSidebar(images: self.sideBarImages as! [UIImage])
        callout.delegate = self
        let swipe = sender as! UISwipeGestureRecognizer
        print(swipe.direction)
        if swipe.direction == UISwipeGestureRecognizerDirection.Right {
            callout.show()
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
