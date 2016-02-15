//
//  FilterCell.swift
//  Yelp
//
//  Created by Maha Govindarajan on 2/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FilterCellDelegate {
    optional func filterCell(filterCell :FilterCell,
        didChangeValue value : Bool )
}

class FilterCell: UITableViewCell {

    @IBOutlet var onSwitch: UISwitch!
    @IBOutlet var switchLabel: UILabel!
    weak var delegate : FilterCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
         self.contentView.layer.borderWidth = 1
         self.contentView.layer.cornerRadius = 3
        self.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
     onSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged() {
            delegate?.filterCell?(self, didChangeValue: onSwitch.on)
    }

}
