//
//  SignupViewController.swift
//  MDBSocials
//
//  Created by Edward Liu on 3/11/16.
//  Copyright © 2016 Edward Liu. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var firstname: UITextField!
    
    @IBOutlet weak var lastname: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmpassword: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    func displayAlert(title: String, displayError: String) {
        let alert = UIAlertController(title: title, message: displayError, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func signupUser(sender: AnyObject) {
        var displayError = ""
        if username.text == "" && password.text == "" {
            displayError = "Please enter a username and password"
        } else if username.text == "" {
            displayError = "Please enter a username"
        } else if password.text == "" || confirmpassword.text == ""{
            displayError = "Please enter your password twice"
        } else if firstname.text == "" || lastname.text == "" {
            displayError = "Please enter your full name"
        } else if email.text == "" {
            displayError = "Please enter your email"
        } else if password.text != confirmpassword.text {
            displayError = "Passwords must match"
        }
        if displayError != "" {
            displayAlert("Error In Form", displayError: displayError)
        } else {

        let user = PFUser()
        user.username = username.text
        user.password = password.text
        user.email = email.text
        user["firstName"] = firstname.text
        user["lastName"] = lastname.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded, signupError) -> Void in
            
            if signupError == nil {
            self.performSegueWithIdentifier("signuptoFeed", sender: self)
                
            } else {
                if let error = signupError!.userInfo["error"] as? NSString {
                    displayError = error as String
                } else {
                    displayError = "Please try again later"
                }
                self.displayAlert("Could not signup", displayError: displayError)
            }
        }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
