//
//  DropDownTableViewCell.swift
//  Yelp
//
//  Created by Maha Govindarajan on 2/14/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import DropDown

class DropDownTableViewCell: UITableViewCell {

    @IBOutlet var arrow: UIImageView!
    @IBOutlet var dropButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func click(sender: AnyObject) {
    }
}
