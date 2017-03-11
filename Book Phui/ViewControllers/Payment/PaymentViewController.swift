//
//  PaymentViewController.swift
//  Book Phui
//
//  Created by thjnh195 on 3/11/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.serviceCollectionView.register(UINib(nibName: String(describing: AddServiceCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "Cell")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPurchaseClicked(_ sender: UIButton) {
        
    }
    
    func keyboardWillShow(_ notification: Notification) {
        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
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
