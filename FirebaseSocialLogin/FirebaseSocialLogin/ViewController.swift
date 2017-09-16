//
//  ViewController.swift
//  FirebaseSocialLogin
//
//  Created by Tiago Bastos on 26/07/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import TwitterKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFBButtons()
        
        setupGoogleButtons()
        
        setupTwitterButton()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    fileprivate func setupTwitterButton(){
        let twitterButton = TWTRLogInButton{
            (session, error) in
            
            if let err = error {
                print("Failed to login via Twitter: " , err)
                return
            }
            
            print("Successfully logged in under Twitter..")
        }
        
        view.addSubview(twitterButton)
        
        twitterButton.frame = CGRect(x: 16, y: 116 + 66 + 66 + 66, width: view.frame.width - 32, height: 50)

    }
    
    fileprivate func setupGoogleButtons(){
        let googleSignInButton = GIDSignInButton()
        googleSignInButton.frame = CGRect(x: 16, y: 116 + 66, width: view.frame.width - 32, height: 50)
        
        let customButton = UIButton(type: .system)
        customButton.frame = CGRect(x: 16, y: 116 + 66 + 66, width: view.frame.width - 32, height: 50)
        customButton.backgroundColor = .orange
        customButton.setTitle("Custom Google Sign in", for: .normal)
        customButton.setTitleColor(.white, for: .normal)
        customButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        view.addSubview(customButton)
        view.addSubview(googleSignInButton)
        
        customButton.addTarget(self, action: #selector(handleCustomLogin), for: .touchUpInside)
    }
    
    func handleCustomLogin() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    fileprivate func setupFBButtons(){
        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate = self
        
        loginButton.readPermissions = ["email", "public_profile"]
        
        let customFBButton = UIButton(type: .system)
        customFBButton.backgroundColor = .blue
        customFBButton.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
        customFBButton.setTitle("Custom FB Login here", for: .normal)
        customFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        customFBButton.setTitleColor(.white, for: .normal)
        view.addSubview(customFBButton)
        
        customFBButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)

    }
    
    func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self){
            (result, error) in
            if error != nil {
                print("Custom FB Login failed: ", error ?? "")
                return
            }
            
            self.showEnailAddress()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("did log out")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        showEnailAddress()
        
    }
    
    func showEnailAddress() {
        
        let accesstoken = FBSDKAccessToken.current()
        
        guard let accessTokenString = accesstoken?.tokenString else {return}
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if error != nil {
                print("Error with FB User: ", error ?? "")
                return
            }
            
            print("Successfully logged in: ", user ?? "")

        }
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start {
            (connection, result, err) in
            
            if err != nil {
                print("failed to start graph request: ", err ?? "")
                return
            }
            
            print(result ?? "")
            
            
        }
        
    }
    
    
}

