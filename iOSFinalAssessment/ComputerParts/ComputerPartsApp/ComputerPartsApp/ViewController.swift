//
//  ViewController.swift
//  ComputerPartsApp
//
//  Created by Akkshay Khoslaa on 3/16/16.
//  Copyright © 2016 Akkshay Khoslaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var partNames = ["harddrive", "keyboard", "mouse", "processor", "screen"]
    var partImages = ["harddrive", "keyboard", "mouse", "processor", "screen"]
    var companyName = ["amd", "toshiba", "apple", "nvidia", "dell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return partNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("partsCell", forIndexPath: indexPath) as! TableViewCell
        cell.partLabel.text = partNames[indexPath.row]
        cell.partImage.image = UIImage(named: partImages[indexPath.row])
        return cell
    }
    
    var row = 0
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        row = indexPath.row
        self.performSegueWithIdentifier("toCompany", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! CompanyViewController
        vc.companyName = companyName[row]
    }
    


}

