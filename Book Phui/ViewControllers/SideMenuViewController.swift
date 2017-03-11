//
//  SideMenuViewController.swift
//  Book Phui
//
//  Created by Thanh Tran on 3/10/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit
import FirebaseAuth
import SDWebImage

class SideMenuViewController: UIViewController {
    struct Content {
        var title: String
        var imageName: String
    }
    
    @IBOutlet weak var avatarImage: UIAvatar!
    @IBOutlet weak var biggerAvatarImage: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var tableView: UITableView!

    let contents: [Content] = [
        Content(title: "Sân bóng đã đặt", imageName: "stadiumIcon"),
        Content(title: "Voucher", imageName: "voucherIcon"),
        Content(title: "Phương thức thanh toán", imageName: "paymentIcon"),
        Content(title: "Cài đặt", imageName: "settingIcon"),
        Content(title: "Đăng xuất", imageName: "logoutIcon")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: String(describing: SideMenuViewCell.self), bundle: nil), forCellReuseIdentifier: "Cell")
        
        lbName.text = FIRAuth.auth()?.currentUser?.displayName
        
        if let photoURL = FIRAuth.auth()?.currentUser?.photoURL {
            avatarImage.sd_setImage(with: photoURL)
            biggerAvatarImage.sd_setImage(with: photoURL)
        }
    }
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SideMenuViewCell
        
        cell.lbTitle.text = contents[indexPath.row].title
        cell.iconImage.image = UIImage(named: contents[indexPath.row].imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        default:
            break
        }
    }
}
