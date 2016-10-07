//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by Lakshay Khatter on 9/23/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import Foundation

extension ParseClient {
    
    struct ParseConstants {
        // https://parse.udacity.com/parse/classes
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse"
    }
    
    struct ParseAPIKey {
        static let Parse_Application_ID = "X-Parse-Application-Id"
        static let REST_API_Key = "X-Parse-REST-API-Key"
    }
    
    struct ParseAPIValue {
        static let Parse_Application_ID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let REST_API_Key = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
    struct ParseMethods {
        static let studentLocation = "/classes/StudentLocation"
    }
    
    struct ParameterKey {
        static let query = "where"
        static let limit = "limit"
        static let skip = "skip"
        static let order = "order"
        
    }
    
    struct JSONResponseKeys {
        
        //MARK: result
        static let result = "results"
        
        // MARK: StudentLocation
        static let StudentLocationObjectId = "objectId"
        static let StudentLocationUniqueKey =  "uniqueKey"
        static let StudentLocationFirstName = "firstName"
        static let StudentLocationLastName = "lastName"
        static let StudentLocationMapString = "mapString"
        static let StudentLocationMediaURL = "mediaURL"
        static let StudentLocationLatitude = "latitude"
        static let StudentLocationLongitude = "longitude"
        static let StudentLocationCreatedAt = "createdAt"
        static let StudentLocationUpdatedAt = "updatedAt"
        static let StudentLocationACL = "ACL"
        
        
    }
    
}




