//
//  LoginViewController.swift
//  MDBSocials
//
//  Created by Edward Liu on 3/11/16.

//  Copyright © 2016 Edward Liu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    func displayAlert(title: String, displayError: String) {
        let alert = UIAlertController(title: title, message: displayError, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
            self.dismissViewControllerAnimated(true, completion: nil)
            }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        var displayError = ""
        if username.text == "" && password.text == "" {
            displayError = "Please enter a username and password"
        } else if username.text == "" {
            displayError = "Please enter a username"
        } else if password.text == "" {
            displayError = "Please enter a password"
        }
        
        if displayError != "" {
            displayAlert("Error In Form", displayError: displayError)
        } else {
        
            PFUser.logInWithUsernameInBackground(username.text!, password: password.text!) {
                (success, loginError) in
                
                if loginError == nil {
                    self.performSegueWithIdentifier("toFeed", sender: self)
                    
                } else {
                    if let errorString = loginError!.userInfo["error"] as? NSString {
                        displayError = errorString as String
                    } else {
                        displayError = "Please try again"
                    }
                    self.displayAlert("could not login", displayError: displayError)
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
