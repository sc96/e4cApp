//
//  UserController.swift
//  e4cApp
//
//  Created by Sam on 4/23/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserController: WebService {
    
    var currentUser : User?
    var manager = FileManager.default
    
    var tempWebinarFilters : [Bool] = [false, false, false, false, false, false, false, false, false]
    var tempArticleFilters : [Bool] = [false, false, false, false, false, false, false, false, false]
    
    static let sharedInstance = UserController()
    private override init() {}
    
    func loginUser(email: String, password: String, onCompletion: @escaping (User?, String?) -> Void) {
        

        
        let parameters = ["email": email, "password" : password]

        
        
        
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/login", method: .post, parameters: parameters)
        
      //  let request = WebService.createMutableRequest(url: "http://localhost:8080/api/login", method: .post, parameters: parameters)
            
        
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            if (responseCode == 200) {
                
                print(json)
                
                var user_email : String = json["user_email"].rawString()!
                var profStatus = json["user_profstatus"].rawValue as! Int
                var expertise : Int = json["user_expertise"].rawValue as! Int
                var country : Int = json["user_country"].rawValue as! Int
                var affiliation : Int = json["user_affiliation"].rawValue as! Int
                var user_age : Int = json["user_age"].rawValue as! Int
                var user_gender : Int = json["user_gender"].rawValue as! Int
                var user_id : String = json["id"].rawString()!
                var last_name : String = json["user_lastname"].rawString()!
                var first_name : String = json["user_firstname"].rawString()!

                var user_descript : String = json["user_dscription"].rawString()!
                
                
                // var user_projects : [Int] = json["user_projects"].rawValue as! [Int]
                // var fav_webinars : [Int] = json["fav_webinars"].rawValue as! [Int]
                // var fav_articles : [Int] = json["fav_articles"].rawValue as! [Int]
                
                var user_projects : [String] = []
                var fav_webinars : [Int] = []
                var fav_articles : [Int] = []
                
                if (!json["user_projects"].isEmpty) {
                    user_projects = json["user_projects"].rawValue as! [String]
                }
                
                if (!json["fav_webinars"].isEmpty) {
                    fav_webinars = json["fav_webinars"].rawValue as! [Int]
                }
                
                if (!json["fav_articles"].isEmpty) {
                    fav_articles = json["fav_articles"].rawValue as! [Int]
                }
                
                var user = User(email: user_email, professionalStatus: profStatus, affiliation: affiliation, expertise: expertise, country: country, ageRange: user_age, gender: user_gender, id: user_id)
                
            
                user.firstName = first_name
                user.lastName = last_name
                user.articleFilters = self.tempArticleFilters
                user.webinarFilters = self.tempWebinarFilters
                user.user_descript = user_descript
                user.favoritedArticles = fav_articles
                user.favoritedWebinars = fav_webinars
                user.createdProjects = user_projects
                

                
                onCompletion(user,nil)
            }
            
            else {
                
                
                let errorMessage = "Incorrect login information"
                onCompletion(nil, errorMessage)
                
            }
            
            
        })
        
   
    
        
    }
    
    
    func registerUser(email:String, password : String, professionalStatus : Int, affiliation : Int, expertise : Int, country : Int, ageRange : Int, gender : Int,
                      onCompletion: @escaping (User?, String?) -> Void) {
        
        
        let parameters : [String : Any] = ["profstatus" : professionalStatus, "affiliation" : affiliation, "expertise" : expertise, "country" : country, "age" : ageRange, "gender": gender, "email" : email, "password" : password]
        
        
        let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/createaccount", method: .post, parameters: parameters)
        
       // let request = WebService.createMutableRequest(url: "http://localhost:8080/api/createaccount", method: .post, parameters: parameters)
        

        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            if (responseCode == 200) {
                
                print(json)
                
                
                
                var user_id = json["id"].rawString()!
                var user = User(email: email, professionalStatus: professionalStatus, affiliation: affiliation, expertise: expertise, country: country, ageRange: ageRange, gender: gender, id: user_id)
                
                
               //  user.firstName = first_name
              //   user.lastName = last_name
                user.articleFilters = self.tempArticleFilters
                user.webinarFilters = self.tempWebinarFilters
                
                
                
                onCompletion(user,nil)
            }
                
            else {
                
                
                let errorMessage = "Email already in use"
                onCompletion(nil, errorMessage)
                
            }
            
            
        })
        
        
    }
    
    func editUser(firstName : String, lastName: String, professionalStatus : Int, affiliation : Int, expertise : Int, country : Int, ageRange : Int, gender : Int, id : String, description : String, onCompletion: @escaping (Int, String) -> Void) {
        
        
        let parameters : [String : Any] = ["profstatus" : professionalStatus, "affiliation" : affiliation, "expertise" : expertise, "country" : country, "age" : ageRange, "gender": gender, "id" : id, "user_description" : description, "firstname" : firstName, "lastname" : lastName]
        
         let request = WebService.createMutableRequest(url: "https://e4ciosserver.herokuapp.com/api/editaccount", method: .post, parameters: parameters)
        
      //  let request = WebService.createMutableRequest(url: "http://localhost:8080/api/editaccount", method: .post, parameters: parameters)
        
        WebService.executeRequest(urlRequest: request, requestCompletionFunction: {(responseCode, json) in
            
            print(responseCode)
            
            if (responseCode == 200) {
            
            
                
                self.currentUser!.firstName = firstName
                self.currentUser!.lastName = lastName
                self.currentUser!.user_descript = description
                self.currentUser!.ageRange = ageRange
                self.currentUser!.gender = gender
                self.currentUser!.country = country
                self.currentUser!.expertise = expertise
                self.currentUser!.professionalStatus = professionalStatus
                
                
                let documents = self.manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileUrl = documents.appendingPathComponent("info.txt")
                NSKeyedArchiver.archiveRootObject(UserController.sharedInstance.currentUser!, toFile: fileUrl.path)
                
                let message = "Saved"
                
                onCompletion(responseCode, message)
            }
                
            else {
                
                
                let errorMessage = "Something bad happened"
                onCompletion(responseCode, errorMessage)
                
            }
            
            
        })

    }
    
    

    
    
    
    
    
}
