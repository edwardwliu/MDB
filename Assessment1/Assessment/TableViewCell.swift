
//
//  TableViewCell.swift
//  Assessment
//
//  Created by Edward Liu on 3/2/16.
//  Copyright © 2016 Edward Liu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var countrynamelabel: UILabel!
    
    @IBOutlet weak var countryimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
