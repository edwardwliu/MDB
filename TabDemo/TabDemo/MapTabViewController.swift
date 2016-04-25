//
//  MapTabViewController.swift
//  TabDemo
//
//  Created by Virindh Borra on 10/31/15.
//  Copyright © 2015 Virindh Borra. All rights reserved.
//

import UIKit
import MapKit

class MapTabViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBAction func segmentChanged(sender: AnyObject) {
        //The Segemnt selected changed, change the map type
        //0 = default
        //1 = Satellite
        if (segmentControl.selectedSegmentIndex == 0)//Fill it in
        {
            mapView.mapType = .Standard;
            //We want to change the map to the default map type
        }else {
            
            mapView.mapType = .Satellite
            //Set the map type to be satellite
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
