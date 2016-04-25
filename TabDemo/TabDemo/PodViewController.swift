//
//  PodViewController.swift
//  TabDemo
//
//  Created by Virindh Borra on 2/27/16.
//  Copyright © 2016 Virindh Borra. All rights reserved.
//

import UIKit
import TVButton

class PodViewController: UIViewController {

    @IBOutlet weak var myButton: TVButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let background = TVButtonLayer(image: UIImage(named: "KyloA")!)
        let pattern = TVButtonLayer(image: UIImage(named: "KyloB")!)
        let top = TVButtonLayer(image: UIImage(named: "KyloC")!)
        let fourth = TVButtonLayer(image: UIImage(named: "KyloE")!)
        myButton.layers = [background, pattern, top]

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
