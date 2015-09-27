//
//  CategoryTableViewCell.swift
//  My People
//
//  Created by Mkwilfreid-Mpunia on 2015/09/25.
//  Copyright (c) 2015 Mkwilfreid-Mpunia. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - Outtlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorPicked: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
