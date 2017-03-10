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

class MainViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: UIView!
    var map : GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMap()
        self.mapView.addSubview(self.map)
        self.mapView.addSubview(map)
        //Add autolayout to map
        self.map.translatesAutoresizingMaskIntoConstraints=false
        self.mapView.addConstraint(NSLayoutConstraint(item: map, attribute: .centerX, relatedBy: .equal, toItem: self.mapView, attribute: .centerX, multiplier: 1, constant: 0))
        self.mapView.addConstraint(NSLayoutConstraint(item: map, attribute: .centerY, relatedBy: .equal, toItem: self.mapView, attribute: .centerY, multiplier: 1, constant: 0))
        self.mapView.addConstraint(NSLayoutConstraint(item: map, attribute: .width, relatedBy: .equal, toItem: self.mapView, attribute: .width, multiplier: 1.0, constant: 0))
     
        self.mapView.addConstraint(NSLayoutConstraint(item: map, attribute: .height, relatedBy: .equal, toItem: self.mapView, attribute: .height, multiplier: 1, constant: 0))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        try! firebaseAuth?.signOut()
        
    }
    
    // MARK: - Setup Map
    func setupMap(){
        self.view.layoutIfNeeded()

        map = GMSMapView()
        let camera = GMSCameraPosition.camera(withLatitude: 21.0257831902888,
                                                          longitude: 105.84667827934, zoom: 15)
        
        map = GMSMapView.map(withFrame: self.mapView.frame, camera: camera)
        
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
        map.delegate = self
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
