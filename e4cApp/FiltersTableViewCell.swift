//
//  FiltersTableViewCell.swift
//  e4cApp
//
//  Created by Sam on 4/7/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class FiltersTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageLabel: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
