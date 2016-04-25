//
//  ViewController.swift
//  Pixplore
//
//  Created by Mansi Shah on 4/2/16.
//  Copyright © 2016 Mansi Shah. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    

    @IBOutlet var loginButton: UIButton!
    @IBOutlet var pixploreTitle: UILabel!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var loginLine: UIView!
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
           // Do any additional setup after loading the view, typically from a nib.
        var currUser = PFUser.currentUser()
//        if (currUser != nil) {
//            self.performSegueWithIdentifier("toTabBar", sender: self)
//        }
        self.signUpButton.highlighted = false
        self.loginButton.highlighted = true
        
        loginButton.layer.cornerRadius = loginButton.frame.height/4.5
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        var currUser = PFUser.currentUser()
        backgroundImage.frame = self.view.bounds
        pixploreTitle.frame = CGRect(x: 20, y: 121 , width: 280, height: 75)
        var loginFrame = loginButton.frame
        var lineFrame = CGRectMake(loginFrame.origin.x, loginFrame.origin.y + 30, loginFrame.width, 1)
        loginLine.frame = lineFrame
        pixploreTitle.font = UIFont(name: "KaushanScript-Regular", size: 55)
        loginButton.setTitle("LOG IN", forState: .Normal)
        loginButton.titleLabel!.font = UIFont(name: "Raleway~SemiBold", size: 17)
        loginLine.frame = CGRectOffset(loginFrame, 0, 20)
        if (currUser != nil) {
            self.performSegueWithIdentifier("toTabBar", sender: self)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlert(title: String, displayError: String) {
        let alert = UIAlertController(title: title, message: displayError, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in self.dismissViewControllerAnimated(true, completion: nil)}))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func logInPressed(sender: AnyObject) {
        var displayError = ""
        if usernameTextField.text == "" && passwordTextField.text == "" {
            displayError = "Please enter a username and password"
        } else if usernameTextField.text == "" {
            displayError = "Please enter a username"
        } else if passwordTextField.text == "" {
            displayError = "Please enter a password"
        }
        
        if displayError != "" {
            displayAlert("Error in Form", displayError: displayError)
        } else {
            PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) {
                (success, loginError) in
                
                if loginError == nil {
//                    self.performSegueWithIdentifier("toTabBar", sender: self)
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    if let errorString = loginError!.userInfo["error"] as? NSString {
                        displayError = errorString as String
                    } else {
                        displayError = "Please try again later."
                    }
                    self.displayAlert("Could not Login", displayError: displayError)
                }
            }
        }
    }


    @IBAction func signupClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("toSignUp", sender: self)
    }
}

