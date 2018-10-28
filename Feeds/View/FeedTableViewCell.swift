//
//  FeedTableViewCell.swift
//  Feeds
//
//  Created by Abhishek Singh on 28/10/18.
//  Copyright © 2018 Abhishek Singh. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var mediaVideoView: PlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mediaImageView.isHidden = false
        mediaVideoView.isHidden = false
    }

}
