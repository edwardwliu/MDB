
//
//  TableViewCell.swift
//  ComputerPartsApp
//
//  Created by Edward Liu on 4/6/16.
//  Copyright © 2016 Akkshay Khoslaa. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var partImage: UIImageView!
    @IBOutlet weak var partLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
