//
//  ViewController.swift
//  MDBSocials
//
//  Created by Edward Liu on 3/9/16.
//  Copyright © 2016 Edward Liu. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var feedCollectionView: FeedCollectionView!
    
    var events:NSArray = NSArray()

    override func viewDidLoad() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        
        parseQuery()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func parseQuery() {
        let query = PFQuery(className:"Events")
        query.findObjectsInBackground()
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.events = objects!
                self.feedCollectionView?.reloadData()
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = feedCollectionView.dequeueReusableCellWithReuseIdentifier("eventcell", forIndexPath: indexPath) as! CollectionViewCell
        
        print("getting here")

        cell.namelabel.text = events[indexPath.row]["eventName"] as? String
        cell.datelabel.text = events[indexPath.row]["eventDate"] as? String
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier) == "toDetails" {
            let vc = segue.destinationViewController as! DetailViewController
            let row = (sender as! NSIndexPath).item
            vc.currentObject = events[row] as? PFObject
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toDetails", sender: indexPath)
    }

}

