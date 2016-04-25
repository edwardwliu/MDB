//
//  AddMemberViewController.swift
//  ParseLocationDemo
//
//  Created by Akkshay Khoslaa on 11/15/15.
//  Copyright © 2015 Akkshay Khoslaa. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addMember(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

        let newMember = PFObject(className: "Members")
        newMember["firstName"] = firstNameTextField.text
        newMember["lastName"] = lastNameTextField.text
        newMember["email"] = emailTextField.text
        newMember.saveInBackgroundWithTarget(nil, selector: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
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
