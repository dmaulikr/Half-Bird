//
//  SearchingViewController.swift
//  Book Phui
//
//  Created by Thanh Tran on 3/11/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class SearchingViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var stadiums: [Stadium] = []
    var periodOfTime = Stadium.periodOfTime
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.timeTextField.delegate = self
        self.timeTextField.text = periodOfTime[6]
        self.searchTextField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
    }
    
    func showActionSheet() {
        let window = UIApplication.shared.keyWindow
        let initialSelection = periodOfTime.index(of: self.timeTextField.text!)
        
        ActionSheetStringPicker.show(withTitle: "Khung giờ", rows: Stadium.periodOfTime, initialSelection: initialSelection ?? 0, doneBlock: {
            [unowned self] picker, index, value in
            self.timeTextField.text = self.periodOfTime[index]
            self.search()
        }, cancel: nil, origin: window)
    }

    func search() {
        
    }
}

extension SearchingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stadiums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StadiumViewCell
        let item = stadiums[indexPath.row]
        cell.config(with: item)
        return cell
    }
}

extension SearchingViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.showActionSheet()
        return false
    }
    
    func searchTextChanged(_ textField: UITextField) {
        self.search()
    }
}
