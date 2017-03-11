//
//  FieldDetailVC.swift
//  Book Phui
//
//  Created by Thao Truong on 3/10/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit

class FieldDetailVC: UIViewController {
    @IBOutlet var weekdayView: UIView!
    @IBOutlet var btnWeekdays: [UIButton]!
    let today = Date()
    let formatter = DateFormatter()
    
    struct Weekday {
        var title: String
        var day: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configView() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Sân bóng Phạm Hùng A" //ThaoTODO: Rename title
        formatter.dateFormat = "dd/MM"
        self.getDay()
    }
    
    func getDay() {
        let currentWeekday = self.getDayOfWeek()
        for btnWeekday in btnWeekdays {
            self.setDateForButton(btnWeekday, weekday: currentWeekday!)
            if btnWeekday.tag == currentWeekday {
                btnWeekday.isSelected = true
            }
        }
    }
    
    func getDayOfWeek() -> Int? {
        let calendar = Calendar.current
        
        let weekday = calendar.component(.weekday, from: today)
        if (weekday <= 1) {
            return 6;
        } else {
            return weekday - 2;
        }
    }
    
    func setDateForButton(_ button: UIButton, weekday tag:Int) {
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        if (button.tag == tag) {
            button.isSelected = true
            let todayText = formatter.string(from: today)
            button.setTitle("\(button.titleLabel!.text!)\n\(todayText)", for: .normal)
        } else if (button.tag > tag) {
            let dayText = formatter.string(from: today.dateByAddingDays(button.tag - tag))
            button.setTitle("\(button.titleLabel!.text!)\n\(dayText)", for: .normal)
        } else {
            let dayText = formatter.string(from: today.dateByAddingDays(7 - tag + button.tag))
            button.setTitle("\(button.titleLabel!.text!)\n\(dayText)", for: .normal)
        }
    }
    
    //MARK: Button Action
    @IBAction func btnWeekdayClick(_ sender: UIButton) {
    }
    @IBAction func btnBookClick(_ sender: Any) {
        let vc = PaymentViewController(nibName: "PaymentViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
