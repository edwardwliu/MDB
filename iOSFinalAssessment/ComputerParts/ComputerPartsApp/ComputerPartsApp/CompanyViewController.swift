//
//  CompanyViewController.swift
//  ComputerPartsApp
//
//  Created by Edward Liu on 4/6/16.
//  Copyright © 2016 Akkshay Khoslaa. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController {
    
    var companyName = ""

    
    var companyImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyImage.image = UIImage(named: companyName)
        self.companyImage.center.x -= self.view.bounds.width
        UIView.animateWithDuration(0.5, animations: {
            self.companyImage.center.x += self.view.bounds.width})
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.companyImage.center.x -= self.view.bounds.width
        UIView.animateWithDuration(0.5, animations: {
            self.companyImage.center.x += self.view.bounds.width})
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func doneButton(sender: AnyObject) {
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
