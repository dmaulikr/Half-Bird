//
//  TimeCell.swift
//  Book Phui
//
//  Created by Thao Truong on 3/11/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit

class TimeCell: UICollectionViewCell {
    @IBOutlet var lbTime: UILabel!
    @IBOutlet var containerView: UIView!
    var status: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
