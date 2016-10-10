//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Lakshay Khatter on 9/23/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import Foundation


class ParseClient: NSObject {
    
    // shared session
    var session = NSURLSession.sharedSession()
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: GET
    
    func taskForGETMethod(method: String, parameters: [String:AnyObject], completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* 1. Set the parameters */
        var parametersWithApiKey = parameters
        print(UdacityURLFromParameters(parametersWithApiKey, withPathExtension: method))
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(URL: UdacityURLFromParameters(parametersWithApiKey, withPathExtension: method))
        request.addValue(ParseAPIValue.Parse_Application_ID, forHTTPHeaderField: ParseAPIKey.Parse_Application_ID)
        request.addValue(ParseAPIValue.REST_API_Key, forHTTPHeaderField: ParseAPIKey.REST_API_Key)
        if let _ = parameters["where"] {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String, code: Int) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(result: nil, error: NSError(domain: "taskForGETMethod", code: code, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                let code = error?.code
                sendError("There was an error with your request: \(error)", code: code!)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!", code: 1)
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!", code: 1)
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        /* 7. Start the request */
        task.resume()
        return task
    }
    
    // MARK: POST and PUT
    
    func taskForPOSTandPUTMethod(httpMethod: String, method: String, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOSTandPUT: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        let request = NSMutableURLRequest(URL: UdacityURLFromParameters(parameters, withPathExtension: method))
        request.HTTPMethod = httpMethod
        request.addValue(ParseAPIValue.Parse_Application_ID, forHTTPHeaderField: ParseAPIKey.Parse_Application_ID)
        request.addValue(ParseAPIValue.REST_API_Key, forHTTPHeaderField: ParseAPIKey.REST_API_Key)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String, code: Int) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOSTandPUT(result: nil, error: NSError(domain: "taskForPOSTandPUTMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                let code = error?.code
                sendError("There was an error with your request: \(error)", code: code!)
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!", code: 1)
                return
            }
            //print(data)
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPOSTandPUT)
            //print(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        task.resume()
        return task
    }
    
    
    // create a URL from parameters
    private func UdacityURLFromParameters(parameters: [String:AnyObject], withPathExtension: String? = nil) -> NSURL {
        
        var URLString: String = ""
        
        let components = NSURLComponents()
        components.scheme = ParseConstants.ApiScheme
        components.host = ParseConstants.ApiHost
        components.path = ParseConstants.ApiPath + (withPathExtension ?? "")
        
        URLString = URLString + components.scheme! + "://" + components.host! + components.path! + "?"
        
        for (key, value) in parameters {
            
            if (key == "") {
                continue
            }
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            //components.queryItems!.append(queryItem)
            let query: String = queryItem.name + "=" + queryItem.value!
            let newQ = query.stringByAddingPercentEncodingWithAllowedCharacters(.URLPathAllowedCharacterSet())
            URLString += newQ!
            URLString += "&"
            
        }
        return NSURL(string: URLString)!
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
    
    
}
