//
//  FeedTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Hamada on 8/9/18.
//  Copyright © 2018 Parse. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var labelCell1: UILabel!
    @IBOutlet weak var labelCell2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
