//
//  MainViewController.swift
//  Book Phui
//
//  Created by ThinhND on 3/9/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import GoogleMaps
import SideMenu
import ActionSheetPicker_3_0

class MainViewController: AppViewController, GMSMapViewDelegate, ListFieldDelegate, UITextFieldDelegate {

    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var contraintTimeFilerHeigh: NSLayoutConstraint!
    @IBOutlet weak var contraintTableTop: NSLayoutConstraint!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var tfSearch: UITextField!
    
    @IBOutlet weak var btnTimeSearch: UIButton!
    var map : GMSMapView!
    var listFieldVC : ListFieldViewController!
    var stadiums: [Stadium] = []
    var markers: [GMSMarker] = []
    var periodOfTime = Stadium.periodOfTime
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.sharedInstance.setupLocation()
        self.setupMap()
        self.addMapView()
        self.listFieldVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.StoryBoardID.ListFieldViewControllerID) as! ListFieldViewController
        self.listFieldVC.view.frame = self.listView.bounds
        self.listView.addSubview(self.listFieldVC.view)
        self.listFieldVC.delegate = self
//        self.btnTimeSearch.setTitle(periodOfTime[6], for: .normal)
        self.tfSearch.delegate = self
        self.tfSearch.superview?.superview?.clipsToBounds = true
        self.btnTimeSearch.superview?.superview?.clipsToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func getData() {
        
    }
    
    func updateData() {
        self.getData()
        self.clearMarker()
        for stadium in stadiums {
            let position = CLLocationCoordinate2D(latitude: stadium.lat, longitude: stadium.long)
            let marker = GMSMarker(position: position)
            marker.title = stadium.name
            marker.map = self.map
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        try! firebaseAuth?.signOut()
    }
    
    // MARK: - Textfield delegate
    func didTapTimeSearch() {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.didScrollDown()
        
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tfSearch.resignFirstResponder()
        return true
    }
    
    // MARK: - List field Delegate
    func didScrollDown() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCurlDown, animations: {
            self.contraintTimeFilerHeigh.constant = 50;
            self.contraintTableTop.constant = 220;
            self.view.layoutIfNeeded()
        }, completion: { finished in
            
        })
    }
    
    func didScrollUp() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCurlDown, animations: {
            
            self.contraintTableTop.constant = 0;
            self.view.layoutIfNeeded()
            self.contraintTimeFilerHeigh.constant = 0;
        }, completion: { finished in
            
        })
    }
    
    func didSelectItem() {
        let vc = FieldDetailVC(nibName: "FieldDetailVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Setup Map
    func setupMap(){
        self.view.layoutIfNeeded()

        map = GMSMapView()
        let cor = LocationManager.sharedInstance.locationManager.location?.coordinate
        let camera : GMSCameraPosition!
        if let lat = cor?.latitude, let long = cor?.longitude {
            camera = GMSCameraPosition.camera(withLatitude: lat,
                                              longitude: long, zoom: 15)
        } else {
            camera = GMSCameraPosition.camera(withLatitude: 21.0257831902888,
                                                  longitude: 105.84667827934, zoom: 15)
        }
        
        
        map = GMSMapView.map(withFrame: self.mapView.frame, camera: camera)
        
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
        map.delegate = self
        
    }
    
    func addMapView() {
        self.mapView.addSubview(self.map)
        self.mapView.addSubview(map)
        //Add autolayout to map
        self.map.translatesAutoresizingMaskIntoConstraints=false
        self.mapView.addConstraint(NSLayoutConstraint(item: map, attribute: .centerX, relatedBy: .equal, toItem: self.mapView, attribute: .centerX, multiplier: 1, constant: 0))
        self.mapView.addConstraint(NSLayoutConstraint(item: map, attribute: .centerY, relatedBy: .equal, toItem: self.mapView, attribute: .centerY, multiplier: 1, constant: 0))
        self.mapView.addConstraint(NSLayoutConstraint(item: map, attribute: .width, relatedBy: .equal, toItem: self.mapView, attribute: .width, multiplier: 1.0, constant: 0))
        
        self.mapView.addConstraint(NSLayoutConstraint(item: map, attribute: .height, relatedBy: .equal, toItem: self.mapView, attribute: .height, multiplier: 1, constant: 0))
    }
    
    func clearMarker() {
        for marker in markers {
            marker.map = nil
        }
    }
    
    
    // Mark: - Action
    @IBAction func btnMenuClick(_ sender: Any) {
        
        self.present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func btnTimeSeachClick(_ sender: Any) {
        
        let window = UIApplication.shared.keyWindow
        ActionSheetStringPicker.show(withTitle: "Khung giờ", rows: Stadium.periodOfTime, initialSelection: 0, doneBlock: {
            [unowned self] picker, index, value in
            
            self.btnTimeSearch .setTitle(self.periodOfTime[index], for: .normal)
            }, cancel: nil, origin: window)
    }
    // MARK: - Action
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
