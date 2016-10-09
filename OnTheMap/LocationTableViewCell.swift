//
//  LocationTableViewCell.swift
//  OnTheMap
//
//  Created by Lakshay Khatter on 10/9/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
