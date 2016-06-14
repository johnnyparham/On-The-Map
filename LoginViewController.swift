//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Johnny Parham on 6/8/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: -
    //MARK: Components
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // loading dialog
    var loadingDialog = LoadingDialog()
    
    // textField delegate
    var textDelegate: CredentialsTextFieldDelegate!
    
    // Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textDelegate = CredentialsTextFieldDelegate(screenView: view)
        
        usernameTextField.delegate = textDelegate
        passwordTextField.delegate = textDelegate
    }
    
    
    //MARK: -
    //MARK: Action functions
    
    // Login using the Udacity API
    @IBAction func loginAction(sender: AnyObject) {
        
        if ( verifyFields() ) {
            loadingDialog.showLoading(view)
            
            ConnectionClient.sharedInstance().udacityLogin(usernameTextField.text, password: passwordTextField.text) { (result, error) in
                self.handleLoginResult(ConnectionClient.UdacityAPI.LoginUdacity, result: result, error: error)
            }
        } else {
            showAlertWith("All fields must be completed")
        }
    }
    
    
    // Login using the Facebook API
    @IBAction func loginWithFacebook(sender: AnyObject) {
        
        loadingDialog.showLoading(view)
        
        // facebook access permission array
        let permissions = ["public_profile", "email"]
        
        ConnectionClient.sharedInstance().facebookManager.loginBehavior = FBSDKLoginBehavior.Web
        ConnectionClient.sharedInstance().facebookManager.logInWithReadPermissions(permissions, fromViewController: self) {
            (result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
            
            guard error == nil else {
                self.showAlertWith("Failed to login into FaceBook")
                return
            }
            // get the token
            if result.token != nil {
                
                ConnectionClient.sharedInstance().udacityLoginWithFacebook(result.token.tokenString) {
                     (result, error) in
                    self.handleLoginResult(ConnectionClient.UdacityAPI.LoginFacebook, result: result, error: error)
                }
            } else {
                self.loadingDialog.dismissLoading()
            }
        }
        
    }
    
    
    // Sign up on the Udacity registration site
    @IBAction func signUpAction(sender: AnyObject) {
        let url = NSURL(string: ConnectionClient.UdacityAPI.RegistrationUrl)!
        UIApplication.sharedApplication().openURL(url)
        
    }
    
    //MARK: -
    //MARK: Private functions
    
    // verify if all fields are filled in to do the login
    private func verifyFields() -> Bool {
        return !(usernameTextField.text!.isEmpty) && !(passwordTextField.text!.isEmpty)
    }
    
    // show alert with custom message
    private func showAlertWith(message: String!) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    }
    
    private func handleLoginResult(type: Int!, result: AnyObject!, error: String!) {
        
        // dismiss the loading alert
        dispatch_async(dispatch_get_main_queue(), {
            self.loadingDialog.dismissLoading()
        })
        
        // handle the result
        if let status = result as? Bool where status {
            
            ConnectionClient.UserLogin.loginType = type
            dispatch_async(dispatch_get_main_queue(), {
                self.usernameTextField.text = ""
                self.passwordTextField.text = ""
                
                // move to the next screen
                let controller = self.storyboard!.instantiateViewControllerWithIdentifier("AppTabBarController") as! UITabBarController
                self.presentViewController(controller, animated: true, completion: nil)
            })
        } else {
            
            dispatch_async(dispatch_get_main_queue(), {
                self.showAlertWith(error)
            })
        }
    }

}
