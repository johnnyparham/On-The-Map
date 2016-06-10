//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Johnny Parham on 6/8/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: -
    // MARK: Components
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // textField delegate
    var textDelegate: CredentialsTextFieldDelegate!
    
    // Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textDelegate = CredentialsTextFieldDelegate(screenView: view)
        
        usernameTextField.delegate = textDelegate
        passwordTextField.delegate = textDelegate
    }
    
    
    // MARK: -
    // MARK: Action Functions
    
    // Login using the Udacity API
    @IBAction func loginAction(sender: AnyObject) {
        
    }
    
    
    
    // Login using the Facebook API
    @IBAction func loginWithFacebook(sender: AnyObject) {
        
    }
    
    
    
    
    // Sign up on the Udacity registration site
    @IBAction func signUpAction(sender: AnyObject) {
        
        
    }
    
    // MARK: -
    // MARK: Private functions
    
    // verify if all fields are filled in to do the login
    private func verifyFields() -> Bool {
        return !(usernameTextField.text!.isEmpty) && !(passwordTextField.text!.isEmpty)
    }
    
    // show alert with custom message
    private func showAlertWith(message: String!) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    }

}
