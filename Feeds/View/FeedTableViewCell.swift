//
//  FeedTableViewCell.swift
//  Feeds
//
//  Created by Abhishek Singh on 28/10/18.
//  Copyright © 2018 Abhishek Singh. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mediaView: UIView!
    @IBOutlet weak var mediaImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
