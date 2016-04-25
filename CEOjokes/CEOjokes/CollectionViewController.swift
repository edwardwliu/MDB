//
//  CollectionViewController.swift
//  CEOjokes
//
//  Created by Edward Liu on 2/23/16.
//  Copyright © 2016 Edward Liu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController {
    
    var names = ["Bill Gates", "Steve Jobs", "Tim Cook"]
    var images = ["billgates", "stevejobs", "timcook"]
    var jokes = ["Why did the developer go broke?", "How many programmers does it take to change a lightbulb?", "Why was the javascript developer sad?"]
    var punchline = ["Because he used up all his cache", "None, it's a hardware problem", "Because he didn't node how to Express himself"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return names.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        
        cell.namelabel.text = names[indexPath.item]
        cell.jokeslabel.text = jokes[indexPath.item]
        cell.headshot.image = UIImage(named: images[indexPath.row])
        cell.headshot.layer.cornerRadius = cell.headshot.frame.height/2
        cell.headshot.clipsToBounds = true
        cell.punchline = punchline[indexPath.item]
    
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toproducts", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toproducts") {
            let vc = segue.destinationViewController as! ProductTableViewController
            vc.rowIndex = sender!.row
        
        }
    }
    

    // MARK: UICollectionViewDelegate

    /*

    */

}
