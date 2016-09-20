//
//  UdacityConstant.swift
//  OnTheMap
//
//  Created by Lakshay Khatter on 9/19/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import Foundation

struct UdacityConstants {
    // MARK: URLs
    static let ApiScheme = "https"
    static let ApiHost = "www.udacity.com"
    static let ApiPath = "/api"
}

// MARK: Methods
struct UdacityMethods {
    
    static let Session = "/session"
    static let Users = "/users/<user_id>"
    
}

// MARK: Parameter Keys
struct UdacityParameterKeys {
    
    static let UserId = "key"
    
}

// MARK: JSON Body Keys
struct UdacityJSONBodyKeys {
    
    static let Username = "username"
    static let Password = "password"
}

// MARK: JSON Response Keys
struct UdacityJSONResponseKeys {
    
    // MARK: General
    static let Account = "account"
    static let Session = "session"
    static let StatusMessage = "error"
    static let StatusCode = "status"
    
    // MARK: Authorization
    static let Registration = "registered"
    static let SessionID = "id"
    static let Expiration = "expiration"
    static let UserID = "key"
    
    // MARK: User
    static let user = "user"
    static let firstname = "first_name"
    static let lastname = "last_name"
    
}
