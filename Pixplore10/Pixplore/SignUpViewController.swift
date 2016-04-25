//
//  SignUpViewController.swift
//  Pixplore
//
//  Created by Mansi Shah on 4/2/16.
//  Copyright © 2016 Mansi Shah. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.signUpButton.highlighted = true
        self.loginButton.highlighted = false
        loginButton.layer.cornerRadius = loginButton.frame.height/4.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signInPressed(sender: AnyObject) {

        self.performSegueWithIdentifier("toSignIn", sender: self)
        
    }
    
    func displayAlert(title: String, displayError: String) {
        let alert = UIAlertController(title: title, message: displayError, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in self.dismissViewControllerAnimated(true, completion: nil)}))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func confirmSignUp(sender: AnyObject) {
        var displayError = "Please enter a "
        if username.text == "" {
            displayError += "username"
        } else if firstName.text == "" {
            displayError += "first name"
        } else if lastName.text == "" {
            displayError += "last name"
        } else if password.text == "" {
            displayError += "password"
        } else if email.text == "" {
            displayError += "n email"
        } else if confirmPassword.text == "" {
            displayError = "Please confirm password"
        } else if confirmPassword.text != password.text {
            displayError = "Passwords must match"
        }
        
        if displayError != "Please enter a " {
            displayAlert("Incomplete Form", displayError: displayError)
        } else {
            let user = PFUser()
            user["firstName"] = firstName.text
            user["lastName"] = lastName.text
            user.username = username.text
            user.password = password.text
            user.email = email.text
            
            user.signUpInBackgroundWithBlock { (succeeded, signUpError) -> Void in
                
                if signUpError == nil {
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    if let error = signUpError!.userInfo["error"] as? NSString {
                        displayError = error as String
                    } else {
                        displayError = "Please try again later"
                    }
                    self.displayAlert("Could not Sign Up", displayError: displayError)
                }
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
