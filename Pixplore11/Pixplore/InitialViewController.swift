//
//  InitialViewController.swift
//  Pixplore
//
//  Created by Ali Shelton on 4/24/16.
//  Copyright © 2016 Mansi Shah. All rights reserved.
//

import UIKit
import Parse

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func viewDidAppear(animated: Bool) {
        let currUser = PFUser.currentUser()
        if (currUser == nil) {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("loginVC") as! ViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        else {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("feedTaBVC") as! UITabBarController
            self.presentViewController(vc, animated: true, completion: nil)
        }
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
