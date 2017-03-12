//
//  EventViewCell.swift
//  Book Phui
//
//  Created by Thanh Tran on 3/12/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit
import SDWebImage

class EventViewCell: UITableViewCell {

    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnShareFBClicked(_ sender: UIButton) {
    
    }
    
    @IBAction func btnShareGoogleClicked(_ sender: UIButton) {
    }
    
    func config(with event: Event) {
        if let imageUrl = event.imageUrl, let url = URL(string: imageUrl) {
            bigImageView.sd_setImage(with: url)
        }
        lbTitle.text = event.title
        lbDescription.text = event.desc
    }
}
