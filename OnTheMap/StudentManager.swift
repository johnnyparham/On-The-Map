//
//  StudentManager.swift
//  OnTheMap
//
//  Created by Johnny Parham on 6/12/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation

// Singleton class responsible to hold the list of StudentLocation information from Parser service

class StudentManager {
    
    var studentArray: [StudentLocation] = []
    
    class func sharedInstance() -> StudentManager {
        
        struct Singleton {
            static var sharedInstance = StudentManager()
        }
        
        return Singleton.sharedInstance
    }
    
    // clean the student list when refreshed
    func clean() {
        studentArray.removeAll()
    }
}
