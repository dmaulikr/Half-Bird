//
//  AppDelegate.swift
//  Book Phui
//
//  Created by ThinhND on 3/8/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import GoogleMaps
import SideMenu
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, UNUserNotificationCenterDelegate, FIRMessagingDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(Constants.ConstantsString.GoogleMapAPIKey)
        self.configUI()
        self.configSocialNetwork()
        self.configSideMenu()
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
            // For iOS 10 data message (sent via FCM)
            FIRMessaging.messaging().remoteMessageDelegate = self
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        return true
    }
    
    func configSocialNetwork() {
        FIRApp.configure()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        if (FIRAuth.auth()?.currentUser) != nil {
            self.presentMainScreen()
            print("\(FIRAuth.auth()?.currentUser?.email) + \(FIRAuth.auth()?.currentUser?.displayName) + \(FIRAuth.auth()?.currentUser?.photoURL)")
        } else {
            self.presentLoginScreen()
        }
        
        FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            if FIRAuth.auth()?.currentUser != nil {
                self.presentMainScreen()
            } else {
                self.presentLoginScreen()
                self.configSideMenu()
            }
        }
        

    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {

        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        
        
        completionHandler(UIBackgroundFetchResult.newData)
    }

    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        
    }
    
    func configUI() {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        UINavigationBar.appearance().barTintColor = UIColor(red: 36/255.0, green: 167/255.0, blue: 10/255.0, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-60, -60), for: .default)
    }
    
    func comeToThao() {
        let fieldDetailVC = FieldDetailVC()
        let nav = UINavigationController(rootViewController: fieldDetailVC)
        
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    
    @available(iOS 10, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        print(notification.request.content.userInfo)
    }
    

    @available(iOS 10, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            // ...
            if let error = error {
                // ...
                return
            }
            self.presentMainScreen()
        }
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        self.presentLoginScreen()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication)
    {
        
        FBSDKAppEvents.activateApp();
        
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any)  -> (Bool)
    {
        if url.scheme == "fb377920462578708" {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                                                                         open: url,
                                                                         sourceApplication: sourceApplication,
                                                                         annotation: annotation)
        }else{
            return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    // MARK: - Handle Present
    func presentLoginScreen() -> Void {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let initialViewController = storyboard.instantiateInitialViewController()
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    func presentMainScreen() -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateInitialViewController()
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }

    func configSideMenu() {
        let sideMenu = SideMenuViewController(nibName: String(describing: SideMenuViewController.self), bundle: nil)
        
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: sideMenu)
        menuLeftNavigationController.leftSide = true
        SideMenuManager.menuWidth = 240
        SideMenuManager.menuBlurEffectStyle = .dark
        SideMenuManager.menuEnableSwipeGestures = false
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuPushStyle = .preserve
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
    }
}

