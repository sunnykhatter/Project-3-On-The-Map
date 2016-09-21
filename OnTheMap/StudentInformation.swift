//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Lakshay Khatter on 9/20/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import Foundation

struct StudentInformation {
    
    let objectId, uniqueKey, firstName, lastName, mapString, mediaURL : String
    let latitude, longitude:Double
    
    init(dictionary: [String:AnyObject]) {
        
        // In each of these statements we are checking for nil
        if let id = dictionary["objectId"] {
            self.objectId = id as! String
        } else {
            self.objectId = ""
        }
        
        if let uniqueKey = dictionary["uniqueKey"] {
            self.uniqueKey = uniqueKey as! String
        } else {
            self.uniqueKey = ""
        }
        
        if let firstName = dictionary["firstName"] {
            self.firstName = firstName as! String
        } else {
            self.firstName = ""
        }
        
        if let lastName = dictionary["firstName"] {
            self.lastName = lastName as! String
        } else {
            self.lastName = ""
        }
        
        if let mapString = dictionary["mapString"] {
            self.mapString = mapString as! String
        } else {
            self.mapString = ""
        }
        
        if let mediaURL = dictionary["mediaURL"] {
            self.mediaURL = mediaURL as! String
        } else {
            self.mediaURL = ""
        }
        
        if let latitude = dictionary["latitude"] {
            self.latitude = latitude as! Double
        } else {
            self.latitude = 0
        }
        
        if let longitude = dictionary["longitude"] {
            self.longitude = longitude as! Double
        } else {
            self.longitude = 0
        }
        
        
    }
    
    
}
