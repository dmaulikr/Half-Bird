//
//  AppViewController.swift
//  Book Phui
//
//  Created by Thanh Tran on 3/11/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit
import SideMenu

class AppViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configSideMenu()
    }
    
    func configSideMenu() {
        let sideMenu = UIViewController(nibName: String(describing: SideMenuViewController.self), bundle: nil)
        
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: sideMenu)
        menuLeftNavigationController.leftSide = true
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
//        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
}
