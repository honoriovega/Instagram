//
//  PostCellTableViewCell.swift
//  Instagram
//
//  Created by Honorio Vega on 2/23/18.
//  Copyright © 2018 Honorio Vega. All rights reserved.
//

import UIKit
import ParseUI
class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: PFImageView!
    
    @IBOutlet weak var postText: UILabel!
    var instagramPost: PFObject! {
        didSet {
            self.postImageView.file = instagramPost["media"] as? PFFile
            self.postImageView.loadInBackground()
            self.postText.text = instagramPost["caption"] as? String
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
