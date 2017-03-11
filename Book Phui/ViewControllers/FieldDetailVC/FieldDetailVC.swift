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
        self.navigationItem.title = "Sân bóng Phạm Hùng A" //ThaoTODO: Rename title
        self.getDay()
    }
    
    func getDay() {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        self.getDayOfWeek()
    }
    
    func getDayOfWeek()->Int? {
        let todayDate = NSDate()
        let calendar = Calendar.current
        
        let weekday = calendar.component(.weekday, from: todayDate as Date)
        print("Weekday + \(weekday)")
        return weekday
    }
    //MARK: Button Action
    @IBAction func btnWeekdayClick(_ sender: UIButton) {
    }
    
    
}
