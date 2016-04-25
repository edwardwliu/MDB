//
//  ViewController.swift
//  Assessment
//
//  Created by Edward Liu on 3/2/16.
//  Copyright © 2016 Edward Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var language = ""
    @IBOutlet weak var most_common_language: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        most_common_language.text = language
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

