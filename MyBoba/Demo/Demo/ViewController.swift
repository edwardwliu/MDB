//
//  ViewController.swift
//  Demo
//
//  Created by Edward Liu on 3/17/16.
//  Copyright © 2016 Edward Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var num = ""

    @IBOutlet weak var populationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populationLabel.text = num
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

