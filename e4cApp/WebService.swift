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

class WebService {
    
    
    //MARK:- Utility request creation methods
    class func createMutableRequest(url: String,method: HTTPMethod ,parameters:Dictionary<String, Any>?) -> DataRequest  {
        
        // build request
        let headers :HTTPHeaders = ["Content-Type" : "application/json"]
        

        let request = Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
    
        
        
        return request
    }
    

    
    class func executeRequest (urlRequest: DataRequest, presentingViewController:UIViewController? = nil, requestCompletionFunction:@escaping (Int,JSON) -> ())  {
        
        //add a loading overlay over the presenting view controller, as we are about to wait for a web request
        // presentingViewController?.addLoadingOverlay()
        
        
        urlRequest.responseJSON{ response in
            
            let success = response.result.isSuccess
            if (success) {
                
                
                var json = JSON(response.result.value!)
                
                let serverResponseCode = response.response!.statusCode
                

                
                if (self.handleCommonResponses(responseCode: serverResponseCode, presentingViewController: presentingViewController)) {
                    
                    print("A common bad server response was found.")
                }
                
                requestCompletionFunction(serverResponseCode,json)
            }
            
            else {
                
                let alert = self.connectionErrorAlert()
                presentingViewController?.present(alert, animated: true, completion: nil)
                requestCompletionFunction(0,JSON(""))

            }
        }
    }
    
        
            
    
      /* urlRequest { returnedData -> Void in  //execute the request and give us JSON response data
        
        

            
            //the web service is now done. Remove the loading overlay
            // presentingViewController?.removeLoadingOverlay()
            
            //Handle the response from the web service
            let success = returnedData.result.isSuccess
            if (success)    {
                
                var json = JSON(returnedData.result.value!)
                let serverResponseCode = returnedData.response!.statusCode //since the web service was a success, we know there is a .response value, so we can request the value gets unwrapped with .response!
                
                //                let headerData = returnedData.response?.allHeaderFields
                //                print ("token data \(headerData)")
                
                
                if let validToken = returnedData.response!.allHeaderFields["Access-Token"] {
                    let tokenJson:JSON = JSON(validToken)
                    json["data"]["token"] = tokenJson
                }
                if let validClient = returnedData.response!.allHeaderFields["Client"] as? String    {
                    let clientJson:JSON = JSON(validClient)
                    json["data"]["client"] = clientJson
                }
                
                
                
                if (self.handleCommonResponses(serverResponseCode, presentingViewController: presentingViewController))    {
                    //print to the console that we experienced a common erroneos response
                    print("A common bad server response was found, error has been displayed")
                    
                }
                
                //execute the completion function specified by the class that called this executeRequest function
                //the
                requestCompletionFunction(serverResponseCode,json)
                
            }   else    { //response code is nil - The web service couldn't connect to the internet. Show a "Connection Error" alert, assuming the presentingViewController was given (a UIViewController provided as the presentingViewController parameter provides the ability to show an alert)
                let alert = self.connectionErrorAlert()
                presentingViewController?.presentViewController(alert, animated: true, completion: nil)
                //execute the completion function specified by the class that called this executeRequest function
                requestCompletionFunction(0,JSON(""))
            }
        } */
 

    
    //used by the executeRequest function to show that the app experienced a connection error
    class func connectionErrorAlert() -> UIAlertController {
        let alert = UIAlertController(title:"Connection Error", message:"Not connected", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
    
    //used by the executeRequest function to show that the app experienced a backend server error
    class func server500Alert() -> UIAlertController {
        let alert = UIAlertController(title:"Oh Dear", message:"There was an problem handling your request", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }

    //used by the executeRequest function to check if the app should show any common network errors in an alert
    //returns true if an error and the corresponding alert was activated, or false if no errors were found
    class func handleCommonResponses(responseCode:Int, presentingViewController:UIViewController?) -> Bool {
        //handle session expiry
        if (responseCode == 302)   {
            
            //we are not going to experience this response, yet. This code will never execute
            return true
            
            
        }   else if (responseCode == 500)  {
            
            if let vc = presentingViewController   {
                
                let alert = server500Alert()
                vc.present(alert, animated: true, completion: nil)
                return true
            }
            
            
        }
        
        return false //returning false indicates that no errors were detected
    }
}
