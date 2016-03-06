//
//  ViewController.swift
//  BobaApp
//
//  Created by Jessica  Cherny on 2/29/16.
//  Copyright © 2016 Jessica  Cherny. All rights reserved.
//

import UIKit
import SAConfettiView

class ViewController: UIViewController {

    @IBOutlet weak var WelcomeLabel: UILabel!
    
    @IBAction func BobaButton(sender: AnyObject) {
        performSegueWithIdentifier("toTab", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let confettiView = SAConfettiView(frame: self.view.bounds)
        self.view.addSubview(confettiView)
        confettiView.type = .Confetti
        
        confettiView.colors = [UIColor.redColor(), UIColor.purpleColor(), UIColor.blueColor()]
        confettiView.intensity = 0.75
        confettiView.startConfetti()
        confettiView.userInteractionEnabled = false
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        WelcomeLabel.center.x  = WelcomeLabel.center.x
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.5, delay: 0.4,
            options: [.Repeat, .Autoreverse, .CurveEaseIn], animations: {
                self.WelcomeLabel.center.x += self.view.bounds.width/5
            }, completion: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

