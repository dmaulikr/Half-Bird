//
//  FieldCell.swift
//  Book Phui
//
//  Created by thjnh195 on 3/11/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit

class FieldCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbRank: UILabel!
    @IBOutlet weak var imgAvatar: UIAvatar!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
