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
        boundView.backgroundColor = value ? Constants.selectedColor : Constants.deselectedColor
        smallerView.backgroundColor = value ? Constants.selectedColor : Constants.deselectedColor
    }
}
