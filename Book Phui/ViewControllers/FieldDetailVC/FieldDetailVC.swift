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
    
    @IBOutlet var lbNumField: UILabel!
    @IBOutlet var lbAddress: UILabel!
    let today = Date()
    let formatter = DateFormatter()
    var stadium: Stadium?
    var selectedDate = Date()
    var selectedTime = ""
    
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
        self.navigationItem.title = stadium?.name
        self.lbAddress.text = stadium?.address
        self.lbNumField.text = "\(stadium!.fields) sân"
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
        let imageName = "img_field_\(index+1)"
        imageView.image = UIImage(named: imageName)
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
        vc.stadium = stadium
        vc.time = selectedTime
        vc.date = selectedDate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Support method
    func doSelectWeekday(sender: UIButton) {
        let dayText = sender.titleLabel!.text!.components(separatedBy: "\n")[1]
        selectedDate = formatter.date(from: dayText)!
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
        return Stadium.periodOfTime.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.StoryBoardID.TimeCellID, for: indexPath as IndexPath) as! TimeCell
        cell.lbTime.text = Stadium.periodOfTime[indexPath.row]
        let status = Stadium.arrayStatus[indexPath.row]
        cell.status = status
        if (status == 1) {
            cell.containerView.layer.borderColor = UIColor.lightGray.cgColor
            cell.lbTime.textColor = UIColor.lightGray
        } 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3 - 2, height: 65)
    }
    
    
    //MARK: CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TimeCell
        if cell.status == 1 {
            return
        }
        
        for visibleCell in collectionView.visibleCells {
            if let timeCell = visibleCell as? TimeCell {
                if timeCell.status == 1 {
                    continue
                }
                timeCell.containerView.layer.borderColor = UIColor.black.cgColor
                timeCell.containerView.layer.borderWidth = 1.0;
            }
        }
        cell.containerView.layer.borderColor = UIColor(red: 36/255.0, green: 167/255.0, blue: 10/255.0, alpha: 1).cgColor
        cell.containerView.layer.borderWidth = 2.0;
        selectedTime = Stadium.periodOfTime[indexPath.row]
    }
}
