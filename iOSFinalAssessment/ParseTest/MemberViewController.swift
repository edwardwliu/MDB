//
//  MemberViewController.swift
//  ParseLocationDemo
//
//  Created by Akkshay Khoslaa on 11/15/15.
//  Copyright © 2015 Akkshay Khoslaa. All rights reserved.
//

import UIKit

class MemberViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateData(sender: AnyObject) {
        var query = PFQuery(className: "Members")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock() {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                var newMember = objects![0]
                self.firstNameLabel.text = newMember["firstName"] as? String
                self.lastNameLabel.text = newMember["lastName"] as? String
                self.emailLabel.text = newMember["email"] as? String
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
