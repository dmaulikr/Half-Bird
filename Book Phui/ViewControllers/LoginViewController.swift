//
//  LoginViewController.swift
//  Book Phui
//
//  Created by ThinhND on 3/9/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    
    
    var btnFBLogin: FBSDKLoginButton!

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        print("\(result)")
        if (error == nil) {
            print(result.token.tokenString)
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: result.token.tokenString)
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                // ...
                if let error = error {
                    // ...
                return
                }
            }
        } else {
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        self.btnFBLogin = FBSDKLoginButton()
        self.btnFBLogin.delegate = self;
        self.btnFBLogin.readPermissions = ["public_profile", "email", "user_friends"];
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLoginFBClick(_ sender: Any) {
        self.btnFBLogin.sendActions(for: .touchUpInside)
    }

    @IBAction func btnLoginGGClick(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
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
