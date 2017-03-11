//
//  SideMenuViewCell.swift
//  Book Phui
//
//  Created by Thanh Tran on 3/10/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit

class SideMenuViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var notificationIndicator: UIView!
    @IBOutlet weak var lbNumberNoti: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
