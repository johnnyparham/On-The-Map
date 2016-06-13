//
//  BaseViewController.swift
//  OnTheMap
//
//  Created by Johnny Parham on 6/12/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation

// Class responsible to implement all common methods of the MapViewController and ListViewController

class BaseViewController: UIViewController {
    
    //MARK: -
    //MARK: Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Create and set the logout button */
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BaseViewController.logout))
    }
    
    //MARK: -
    //MARK: Initiate the logout
    
    func logout() {
        
        ConnectionClient.sharedInstance().udacityLogout() { (result, error) in
            
            guard error == nil else {
                self.showAlertWith(error)
                return
            }
            
            if let status = result as? Bool where status {
                StudentManager.sharedInstance().clean()
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            }
            
        }
    }
        
        
    // show alert with custom message
        func showAlertWith(message: String!) {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    
    // Modally present the Information Posting View
    func presentPostingView(delegate: InformationPostingProtocol) {
        let postView = storyboard!.instantiateViewControllerWithIdentifier("InfoPostView") as!
            InformationPostingViewController
        postView.delegate = delegate
        presentViewController(postView, animated: true, completion: nil)
    }
    
    // load student location list
    func loadStudentLocations(completionHandler: (status: AnyObject!, error: String!) -> Void) {
        ConnectionClient.sharedInstance().parseGetStudentLocations() {
             (result, error) in
            completionHandler(status: result, error: error)
        }
    }

}
