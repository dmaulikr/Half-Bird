//
//  FieldDetailVC.swift
//  Book Phui
//
//  Created by Thao Truong on 3/10/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit

class FieldDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configView() {
        self.navigationItem.title = "Sân bóng Phạm Hùng A" //ThaoTODO: Rename title
        
    }
}
