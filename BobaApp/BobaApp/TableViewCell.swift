//
//  TableViewCell.swift
//  BobaApp
//
//  Created by Jessica  Cherny on 2/29/16.
//  Copyright © 2016 Jessica  Cherny. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var bobaImage: UIImageView!
    
    
    @IBOutlet weak var foodLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
