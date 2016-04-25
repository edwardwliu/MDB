//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Edward Liu on 3/9/16.
//  Copyright © 2016 Edward Liu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var currentObject : PFObject?
    
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var locationlabel: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var peoplelabel: UILabel!
    
    @IBAction func going(sender: AnyObject) {
        let currentuser = PFUser.currentUser()!
        currentObject!.addUniqueObject(currentuser["firstName"], forKey:"peopleGoing")
        currentObject!.saveInBackground()
        var peoplestring = ""
        if let value = currentObject!["peopleGoing"] as? NSArray {
            for x in value {
                peoplestring += x as! String + " "
            }
            peoplelabel.text = peoplestring
        }
    }

    @IBAction func notgoing(sender: AnyObject) {
        let currentuser = PFUser.currentUser()!
        currentObject!.removeObject(currentuser["firstName"], forKey: "peopleGoing")
        currentObject!.saveInBackground()
        var peoplestring = ""
        if let value = currentObject!["peopleGoing"] as? NSArray {
            for x in value {
                peoplestring += x as! String + " "
            }
            peoplelabel.text = peoplestring
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let object = currentObject {
            if let value = object["eventName"] as? String {
                namelabel.text = value
            }
            if let value = object["eventDate"] as? String {
                datelabel.text = value
            }
            if let value = object["eventLocation"] as? String {
                locationlabel.text = value
            }
            if let value = object["eventDescription"] as? String {
                descriptionlabel.text = value
            }
            var peoplestring = ""
            if let value = object["peopleGoing"] as? NSArray {
                for x in value {
                    peoplestring += x as! String + " "
                }
                peoplelabel.text = peoplestring
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
