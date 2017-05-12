//
//  WebService.swift
//  e4cApp
//
//  Created by Sam on 4/23/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


// Class used to make API calls
class WebService {
    
    
    //MARK:- Utility request creation methods
    class func createMutableRequest(url: String,method: HTTPMethod ,parameters:Dictionary<String, Any>?) -> DataRequest  {
        
        // build header
        let headers :HTTPHeaders = ["Content-Type" : "application/json"]
        

        // create request
        let request = Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
    
        
        
        return request
    }
    

    
    class func executeRequest (urlRequest: DataRequest, presentingViewController:UIViewController? = nil, requestCompletionFunction:@escaping (Int,JSON) -> ())  {
        
 
        
        urlRequest.responseJSON{ response in
            
            let success = response.result.isSuccess
            let serverResponseCode = response.response!.statusCode
            
            // success
            if (success) {
                
                
                var json = JSON(response.result.value!)
                
            
                
                requestCompletionFunction(serverResponseCode,json)
            }
            
            // not successful
            else {
                

                requestCompletionFunction(serverResponseCode, JSON(""))

            }
        }
    }
    
    
}
