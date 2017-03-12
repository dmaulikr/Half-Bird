//
//  PaymentViewController.swift
//  Book Phui
//
//  Created by thjnh195 on 3/11/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import NVActivityIndicatorView
import SideMenu

class PaymentViewController: AppViewController {

    @IBOutlet weak var lbStName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbFields: UILabel!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbPeriodTime: UILabel!
    @IBOutlet weak var lbMonth: UILabel!
    
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    @IBOutlet weak var tvNoteForOwner: AppTextView!
    @IBOutlet weak var tfCardSerie: AppTextField!
    @IBOutlet weak var tfMobileCode: AppTextField!
    
    var activityIndicatorView : NVActivityIndicatorView!
    
    var stadium: Stadium?
    var time: String?
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.serviceCollectionView.register(UINib(nibName: String(describing: AddServiceCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "Cell")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.delegate = self
        self.serviceCollectionView.allowsMultipleSelection = true
        self.view.addGestureRecognizer(tapGesture)
        self.navigationItem.title = "Đặt sân"
        self.tfMobileCode.keyboardType = .numberPad
        self.tfCardSerie.clearButtonMode = .whileEditing
        self.tfMobileCode.clearButtonMode = .whileEditing
        
        self.lbStName.text = self.stadium?.name
        self.lbAddress.text = self.stadium?.address
        self.lbFields.text = "\(self.stadium!.fields) sân"
        self.lbPeriodTime.text = self.time
        if let date = self.date {
            self.lbMonth.text = "Tháng \(date.month())"
            self.lbDay.text = "\(date.day())"
        }
        
        self.activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), type: .pacman, color: Constants.selectedColor)
        self.activityIndicatorView.center = CGPoint(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2)
        self.view.addSubview(self.activityIndicatorView)
    }
    
    @IBAction func btnPurchaseClicked(_ sender: UIButton) {
        self.activityIndicatorView.startAnimating()
        let transaction = Transaction()
        transaction.stadium = stadium
        transaction.bookedDate = date
        transaction.periodOfTime = time
        transaction.note = tvNoteForOwner.text
        
        Api.pushTransaction(transaction)
        
        Util.delay(3) {
            self.activityIndicatorView.stopAnimating()
            for vc in self.navigationController!.viewControllers {
                if vc is MainViewController {
                    _ = self.navigationController?.popToViewController(vc, animated: true)
                    vc.present(SideMenuManager.menuLeftNavigationController! , animated: true, completion: nil)
                    
                    break
                }
            }
        }
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

extension PaymentViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return self.serviceCollectionView.frame.contains(touch.location(in: self.view))
    }
}

extension PaymentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = min(self.serviceCollectionView.frame.size.width / 3 - 10, 100)
        return CGSize(width: width, height: 28)
    }
}

extension PaymentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Stadium.services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AddServiceCollectionViewCell
        
        cell.lbTitle.text = Stadium.services[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? AddServiceCollectionViewCell
        cell?.selected(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? AddServiceCollectionViewCell
        cell?.selected(false)
    }
}
