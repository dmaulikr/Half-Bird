//
//  HistoryViewCell.swift
//  Book Phui
//
//  Created by Thanh Tran on 3/11/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit
import SDWebImage

class HistoryViewCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIAvatar!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with transaction: Transaction) {
        if let thumbnailUrl = transaction.stadium?.thumbnailUrl, let url = URL(string: thumbnailUrl) {
            avatarImage.sd_setImage(with: url)
        }
        lbName.text = transaction.stadium?.name
        lbAddress.text = transaction.stadium?.address
        lbTime.text = transaction.periodOfTime
        lbDate.text = transaction.bookedDate?.toString(.custom("dd/MM/yyyy"))
    }
}
