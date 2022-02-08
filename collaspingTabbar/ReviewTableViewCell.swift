//
//  ReviewTableViewCell.swift
//  collaspingTabbar
//
//  Created by macbook on 8/2/2565 BE.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet var reviewString: UITextView!
    @IBOutlet var reviewImage: UIImageView!
    @IBOutlet var reviewName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
