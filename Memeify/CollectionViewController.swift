//
//  CollectionViewController.swift
//  Hackshop1
//
//  Created by SAMEER SURESH on 2/19/16.
//  Copyright © 2016 SAMEER SURESH. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController {
    var names = ["Pepe", "DJ Khaled", "Shia Labeouf", "Doge", "Vladimir Putin??", "Meta Inception App Baby", "V-DAWG"]
    var images = ["pepe", "khaled", "shia", "doge", "putin", "metababy", "virindh"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animateWithDuration(1.0, animations: ({
            self.label.center.x = self.view.frame.height - 30
            
        }), completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.image.image = UIImage(named: "gradient")
        cell.nameLabel.text = names[indexPath.item]
        return cell
    }

        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare
    ForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
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
        return names.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toImage"){
            let vc = segue.destinationViewController as! MemePictureViewController
            let row = (sender as! NSIndexPath).item;
            let imageName = images[row]
            vc.imageName = imageName
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toImage", sender: indexPath)
    }`

}
