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



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.configSocialNetwork()
//        self.configUI()
        
        return true
    }
    
    func configSocialNetwork() {
        FIRApp.configure()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        
        if (FIRAuth.auth()?.currentUser) != nil {
            self.presentMainScreen()
        } else {
            self.presentLoginScreen()
        }
        
        FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            if FIRAuth.auth()?.currentUser != nil {
                self.presentMainScreen()
            } else {
                self.presentLoginScreen()
            }
        }
    }

    func configUI() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        UINavigationBar.appearance().barTintColor = UIColor(red: 36/255.0, green: 167/255.0, blue: 10/255.0, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
    UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-60, -60), for: .default)
    }
    
    // MARK: - Firebase Auth
//    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
//        -> Bool {
//            
//            return GIDSignIn.sharedInstance().handle(url,
//                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
//                                                     annotation: [:])
//    }
    
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

}

