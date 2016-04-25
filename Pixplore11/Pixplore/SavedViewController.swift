//
//  SavedViewController.swift
//  Pixplore
//
//  Created by Mansi Shah on 4/9/16.
//  Copyright © 2016 Mansi Shah. All rights reserved.
//

import UIKit
import Parse

class SavedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var savedObjects = Array<PFObject>()
    var refreshControl = UIRefreshControl()
    var sortbyType = "createdAt"
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        getPosts()
        self.collectionView.reloadData()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.savedObjects.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell1", forIndexPath: indexPath) as! SavedCollectionViewCell
        
        self.savedObjects[indexPath.row]["photo"].getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                let tempImage = UIImage(data: imageData!)
                cell.savedImage.image = tempImage
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("saveToDetail", sender: indexPath)
    }
    
    @IBAction func segmentButton(sender: AnyObject) {
        if segmentView.selectedSegmentIndex == 0 {
            sortbyType = "createdAt"
        } else {
            sortbyType = "popular"
        }
        refresh(self)
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
        self.savedObjects = Array<PFObject>()
        let currentUser = PFUser.currentUser()
        print(currentUser)
        var saved = currentUser!["savedImages"] as! Array<PFObject>
        print("saved: ", saved)
        let query = PFQuery(className: "Photo")
        if (sortbyType == "createdAt") {
            query.orderByDescending("createdAt")

        } else {
            query.orderByDescending("numberofSaves")
        }
         query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                print("Successfully retrieved \(objects!.count) photos.")
                if let objects = objects {
                    if objects.count == 0 {
                        print("there is nothing to display")
                    }
                    else {
                        for object in objects {
                            if saved.contains(object) && !self.savedObjects.contains(object) {
                                self.savedObjects.append(object)
                            }
                        }

                    }                    //self.savedObjects = objects
                    self.collectionView.reloadData()
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveToDetail" {
            let vc = segue.destinationViewController as! DetailsViewController
            var index = (sender as! NSIndexPath).item
            self.savedObjects[index]["photo"].getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    vc.picture.image = UIImage(data: imageData!)!
                }
            }
            vc.caption = (self.savedObjects[index]["description"] as! String)
            vc.userName = (self.savedObjects[index]["username"] as! String)
            vc.numSaves = (self.savedObjects[index]["numberofSaves"] as! Int)
            //vc.date = (savedObjects[index]["createdAt"] as! String)
            vc.location = (self.savedObjects[index]["location"] as! PFGeoPoint)
            vc.photoObject = (self.savedObjects[index])
            
        }
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
    
}
