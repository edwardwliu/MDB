//
//  ImageTabViewController.swift
//  ViewsTest
//
//  Created by Virindh Borra on 11/13/15.
//  Copyright © 2015 Virindh Borra. All rights reserved.
//

import UIKit
import MapKit

class MapTabViewController: UIViewController {

    @IBOutlet weak var segmentView: UISegmentedControl!
    
    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentButton(sender: AnyObject) {
        if segmentView.selectedSegmentIndex == 0 {
            myMapView.mapType = .Standard
        } else if segmentView.selectedSegmentIndex == 1 {
            myMapView.mapType = .Satellite
        } else {
            myMapView.mapType = .Hybrid
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
