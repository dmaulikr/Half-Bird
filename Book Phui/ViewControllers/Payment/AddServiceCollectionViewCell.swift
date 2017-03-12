//
//  AddServiceCollectionViewCell.swift
//  Book Phui
//
//  Created by Thanh Tran on 3/11/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit

class AddServiceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var boundView: UIView!
    @IBOutlet weak var smallerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func selected(_ value: Bool) {
        lbTitle.textColor = value ? Constants.selectedColor : Constants.deselectedColor
        boundView.borderColor = value ? Constants.selectedColor : Constants.deselectedColor
        if value {
            smallerView.backgroundColor = Constants.selectedColor
            smallerView.borderWidth = 0
        }
        else {
            smallerView.borderColor = Constants.deselectedColor
            smallerView.backgroundColor = UIColor.clear
            smallerView.borderWidth = 1
        }
    }
}
