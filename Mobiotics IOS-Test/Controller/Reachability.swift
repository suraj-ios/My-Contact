//
//  Reachability.swift
//  MuviStudio
//
//  Created by Arun on 07/07/15.
//  Copyright (c) 2015 Muvi. All rights reserved.
//

import Foundation
open class Reachability {
    
    class func isConnectedToNetwork()->Bool{
        
        var Status:Bool = false
        let url = URL(string: "http://google.com/")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "HEAD"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        var response: URLResponse?
        
        var data = (try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)) as Data?
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                Status = true
            }
        }
        
        return Status
    }
}
