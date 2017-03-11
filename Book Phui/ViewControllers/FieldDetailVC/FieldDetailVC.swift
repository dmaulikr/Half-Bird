//
//  FieldDetailVC.swift
//  Book Phui
//
//  Created by Thao Truong on 3/10/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit
import iCarousel

class FieldDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, iCarouselDataSource, iCarouselDelegate {
    @IBOutlet var weekdayView: UIView!
    @IBOutlet var btnWeekdays: [UIButton]!
    @IBOutlet var collectionTimes: UICollectionView!
    @IBOutlet var constrantHeightCollection: NSLayoutConstraint!
    @IBOutlet var btnBook: UIButton!
    @IBOutlet var slideView: iCarousel!
    @IBOutlet var pageControl: UIPageControl!
    
    let today = Date()
    let formatter = DateFormatter()
    
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
        self.collectionTimes.register(UINib(nibName: Constants.StoryBoardID.TimeCellID, bundle: nil), forCellWithReuseIdentifier: Constants.StoryBoardID.TimeCellID)
        self.constrantHeightCollection.constant = 70 * 3;
        self.configSlideView()
    }
    
    //MARK: Date
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
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.red.cgColor
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
    
    //Slide Image
    func configSlideView() {
        self.slideView.delegate = self
        self.slideView.dataSource = self
        self.slideView.bounces = false
        self.slideView.isPagingEnabled = true
        self.pageControl.numberOfPages = 2
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 2
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(frame: self.slideView.frame)
        imageView.image = UIImage(named: "img_field_1")
        return imageView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        self.pageControl.currentPage = carousel.currentItemIndex
    }
    
    //MARK: Button Action
    @IBAction func btnWeekdayClick(_ sender: UIButton) {
        self.doSelectWeekday(sender: sender)
    }
    
    @IBAction func btnBookClick(_ sender: Any) {
        let vc = PaymentViewController(nibName: "PaymentViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Support method
    func doSelectWeekday(sender: UIButton) {
        if !sender.isSelected {
            self.deselectAllButton()
            sender.isSelected = true
        }
    }
    
    func deselectAllButton() {
        for subView in self.weekdayView.subviews {
            if subView is UIButton {
                let button = subView as! UIButton
                button.isSelected = false
            }
        }
    }

    //MARK: CollectionViewDatasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.StoryBoardID.TimeCellID, for: indexPath as IndexPath) as! TimeCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3 - 2, height: 65)
    }
    
    
    //MARK: CollectionViewDelegate
    
}
