//
//  TableViewController.swift
//  BobaApp
//
//  Created by Jessica  Cherny on 2/29/16.
//  Copyright © 2016 Jessica  Cherny. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var bobaTableView: UITableView!
    
    var drinks = ["honey", "blueberry","watermelon", "taro", "mango", "strawberry", "green"]
    
    var descrip = ["Housemade tea with rice milk and condensed honey.", "Housemade tea with acai and blueberry flavoring.", "Watermelon flavored tea with slushie mix and boba pearls", "Taro root flavoring adds a funky purple coloring to our bubble tea!", "Mango is our most popular flavor!", "For fruit-lovers, strawberry bubble tea with white pearls is the perfect flavor!", "Green tea flavored bubble milk tea for the inner zen in you."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        bobaTableView.delegate = self
        bobaTableView.dataSource = self
//        bobaTableView.registeClass(TableViewCell.self, forCellReuseIdentifier: "BobaTypeCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinks.count
    }

    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = bobaTableView.dequeueReusableCellWithIdentifier("BobaTypeCell", forIndexPath: indexPath) as! TableViewCell
        
        let image = UIImage(named: drinks[indexPath.row])
        cell.bobaImage.image = image
        cell.bobaImage.layer.cornerRadius = 10
        cell.bobaImage.clipsToBounds = true
        cell.bobaImage.layer.borderColor = UIColor.magentaColor().CGColor
        cell.bobaImage.layer.borderWidth = 3
        
        
        //cell.bobaImage.contentMode = .ScaleAspectFill
        cell.foodLabel.text = descrip[indexPath.row]
        cell.foodLabel.layer.borderColor = UIColor.magentaColor().CGColor
        cell.foodLabel.layer.cornerRadius = 10
        cell.foodLabel.clipsToBounds = true
        cell.foodLabel.layer.borderWidth = 3

        return cell 
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
