//
//  EngineersTableViewCell.swift
//  e4cApp
//
//  Created by Sam on 4/13/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class EngineersTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var countryLabel: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
