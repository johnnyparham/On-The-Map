//
//  PinListViewController.swift
//  OnTheMap
//
//  Created by Johnny Parham on 6/12/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation

class PinListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, InformationPostingProtocol {
    
    //MARK: Components
    @IBOutlet weak var pinTableView: UITableView!
    @IBOutlet weak var actvityView: UIActivityIndicatorView!
    
    //MARK: Actions
    @IBAction func refreshList(sender: AnyObject) {
        StudentManager.sharedInstance().clean()
        
        // hide the tableView and show the activity
        pinTableView.hidden = true
        actvityView.hidden = false
        actvityView.startAnimating()
        
        ConnectionClient.sharedInstance().parseGetStudentLocations { (result, error) in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.actvityView.hidden = true
                    self.showAlertWith(error)
                }
                
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.actvityView.hidden = true
                    self.pinTableView.hidden = false
                    self.pinTableView.reloadData()
                }
            }
            
        }
        
    }
    
    @IBAction func addLocationPin(sender: AnyObject) {
        presentPostingView(self)
        
    }
    
    //MARK: Post delegate
    
    func submitDone() {
        refreshList("")
    }
    
    //MARK: TableView delegate functions
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentManager.sharedInstance().studentArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = PinListTableViewCell()
        
        let studentLocation = StudentManager.sharedInstance().studentArray[indexPath.row]
        cell = tableView.dequeueReusableCellWithIdentifier("PinListCell") as! PinListTableViewCell
        
        cell.setContentWith(studentLocation.firstName, andLastName: studentLocation.lastName, andLocal: studentLocation.mapString, andLatitude: studentLocation.latitude, andLongitude: studentLocation.longitude)
        
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let studentLocation = StudentManager.sharedInstance().studentArray[indexPath.row]
        
        if studentLocation.mediaURL != nil {
            let url = NSURL(string: studentLocation.mediaURL!)
            UIApplication.sharedApplication().openURL(url!)
        } else {
            showAlertWith("There is no information associated with this student")
        }
    }
    
}
