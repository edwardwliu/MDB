

//
//  CollectionViewCell.swift
//  CEOjokes
//
//  Created by Edward Liu on 2/23/16.
//  Copyright © 2016 Edward Liu. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    var punchline = ""
    
    @IBAction func revealbutton(sender: AnyObject) {
        punchlinelabel.text = punchline
    }
    @IBOutlet weak var headshot: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var jokeslabel: UILabel!
    @IBOutlet weak var punchlinelabel: UILabel!
}
