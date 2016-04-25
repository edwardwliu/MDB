//
//  ViewController.swift
//  MyBoba
//
//  Created by Edward Liu on 2/29/16.
//  Copyright © 2016 Edward Liu. All rights reserved.
//

import UIKit
import SAConfettiView

class ViewController: UIViewController {

    override func viewDidLoad() {
        let confettiView = SAConfettiView(frame: self.view.bounds)
        self.view.addSubview(confettiView)
        confettiView.type = .Star
        confettiView.colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor()]
        confettiView.intensity = 0.75
        confettiView.startConfetti()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func enter(sender: AnyObject) {
        self.performSegueWithIdentifier("toTab", sender: nil)
    }

}

