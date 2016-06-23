//
//  CredentialsTextFieldDelegate.swift
//  OnTheMap
//
//  Created by Johnny Parham on 6/8/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import UIKit
import Foundation


class CredentialsTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    let container: UIView!
    
    init(screenView: UIView!) {
        container = screenView
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        subscribeToKeyboardNotification()
    }
    
    // dismiss the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        unsubscribeFromKeyboardNotification()
        return true
    }

    //MARK: keyboard layout functions
    
    // change the size of the view to move up when the keyboard appears
    func keyboardWillShow(notification: NSNotification) {
        container.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    // get the keyboard height from the notification
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.CGRectValue().height
    }
    
    // change the size of the view to move down when the keyboard disappears
    func keyboardWillDismiss(notification: NSNotification)  {
        container.frame.origin.y = 0
    }
    
    
    // add observer to the notification center so we can discover when the keyboard shows up
    
    private func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CredentialsTextFieldDelegate.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CredentialsTextFieldDelegate.keyboardWillDismiss(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // remove the observer from the notification center
    private func unsubscribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
}
