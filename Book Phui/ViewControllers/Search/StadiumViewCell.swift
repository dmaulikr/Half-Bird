//
//  StadiumViewCell.swift
//  Book Phui
//
//  Created by Thanh Tran on 3/11/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit
import SDWebImage

class StadiumViewCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIAvatar!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbRating: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with stadium: Stadium) {
        if let thumbnailUrl = stadium.thumbnailUrl, let url = URL(string: thumbnailUrl) {
            avatarImage.sd_setImage(with: url)
        }
        lbName.text = stadium.name
        lbAddress.text = stadium.address
        lbRating.text = "\(stadium.rating)"
    }
}
