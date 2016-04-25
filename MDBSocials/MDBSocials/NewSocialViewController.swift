//
//  NewSocialViewController.swift
//  MDBSocials
//
//  Created by Edward Liu on 3/9/16.
//  Copyright © 2016 Edward Liu. All rights reserved.
//

import UIKit

class NewSocialViewController: UIViewController {
    
    var newObject = PFObject(className: "Events")
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var dateInput: UITextField!
    
    @IBOutlet weak var locationInput: UITextField!
    
    @IBOutlet weak var descriptionInput: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backtoFeed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func postSocialPressed(sender: AnyObject) {
        
        newObject["eventName"] = nameInput.text
        newObject["eventDate"] = dateInput.text
        newObject["eventLocation"] = locationInput.text
        newObject["eventDescription"] = descriptionInput.text
        
        newObject.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            
            if (success) {
                self.dismissViewControllerAnimated(true, completion: nil)
//             self.performSegueWithIdentifier("posttoFeed", sender: self)
                // The object has been saved.
            } else {
                // There was an error.
            }
        }
        
        

    }
 

}
