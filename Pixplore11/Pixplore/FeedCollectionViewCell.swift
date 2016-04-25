//
//  FeedCollectionViewCell.swift
//  Pixplore
//
//  Created by Mansi Shah on 4/2/16.
//  Copyright © 2016 Mansi Shah. All rights reserved.
//

import UIKit
import Parse

class FeedCollectionViewCell: UICollectionViewCell {
    @IBOutlet var locationImage: UIImageView!
    @IBOutlet var profPicture: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var numSaves: UILabel!
    @IBOutlet var daysAgoPosted: UILabel!
    @IBOutlet var distance: UILabel!
    @IBOutlet var caption: UILabel!
    
    var photoObject: PFObject?
    var saves = 0

    
   
    func viewDidAppear(animated:Bool){
        locationImage.frame = self.bounds
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        let currentUser = PFUser.currentUser()
        if !currentUser!["savedImages"].containsObject(photoObject!) {
            self.saves = self.photoObject!["numberofSaves"] as! Int + 1
            self.photoObject!["numberofSaves"] = self.saves
            currentUser?.addUniqueObject(self.photoObject!, forKey: "savedImages")
            currentUser?.saveInBackgroundWithTarget(nil, selector: nil)
            if (currentUser!["savedImages"] == nil) {
                self.numSaves.text = String(self.saves) + " Save"
            }
            else {
                self.numSaves.text = String(self.saves) + " Saves"
            }
        }
    }
}
