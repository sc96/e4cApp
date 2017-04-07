//
//  ArticleTableViewCell.swift
//  
//
//  Created by Sam on 4/5/17.
//
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var sectorLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    
    @IBOutlet weak var textView: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
