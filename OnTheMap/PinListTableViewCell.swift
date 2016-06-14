//
//  PinListTableViewCell.swift
//  OnTheMap
//
//  Created by Johnny Parham on 6/12/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation

class PinListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentCoordinates: UILabel!
    @IBOutlet weak var studentLocal: UILabel!
    
    func setContentWith(firstName: String!, andLastName lastName: String!, andLocal local: String!, andLatitude latitude: Double!, andLongitude longitude: Double!) {
        studentName.text = firstName + " " + lastName
        studentLocal.text = local
        studentCoordinates.text = "Lat: \(latitude) Lon: \(longitude)"
    }

}
