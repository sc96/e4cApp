//
//  User.swift
//  e4cApp
//
//  Created by Sam on 4/22/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation


class User : NSObject, NSCoding {
    
    
    var email : String
    var firstName : String =  ""
    var lastName : String =  ""
    var id : String
    var professionalStatus : Int
    var affiliation : Int
    var expertise : Int
    var country : Int
    var ageRange : Int
    var gender : Int
    var articleFilters : [Bool] = [false, false, false, false, false, false, false, false, false]
    var webinarFilters : [Bool] = [false, false, false, false, false, false, false, false, false]
    var favoritedArticles : [Int] = []
    var favoritedWebinars : [Int] = []
    var createdProjects : [String] = []
    var user_descript : String = ""
    
    
    
    
    
    init (email:String, professionalStatus : Int, affiliation : Int, expertise : Int, country : Int, ageRange : Int, gender : Int, id : String ) {
        self.email = email
        self.affiliation = affiliation
        self.expertise = expertise
        self.country = country
        self.ageRange = ageRange
        self.gender = gender
        self.professionalStatus = professionalStatus
        self.id = id
    }
    
    
    required init?(coder: NSCoder) {
        
        email = (coder.decodeObject(forKey: "email") as? String) ?? ""
        affiliation = (coder.decodeObject(forKey: "affiliation") as? Int) ?? 0
        firstName = (coder.decodeObject(forKey: "firstName") as? String) ?? ""
        lastName = (coder.decodeObject(forKey: "lastName") as? String) ?? ""
        id = (coder.decodeObject(forKey: "id") as? String) ?? ""
        expertise = (coder.decodeObject(forKey: "expertise") as? Int) ?? 0
        country = (coder.decodeObject(forKey: "country") as? Int) ?? 0
        ageRange = (coder.decodeObject(forKey: "ageRange") as? Int) ?? 0
        gender = (coder.decodeObject(forKey: "gender") as? Int) ?? 0
        professionalStatus  = (coder.decodeObject(forKey: "professionalStatus") as? Int) ?? 0
        
        articleFilters = (coder.decodeObject(forKey: "articleFilters") as? [Bool]) ?? [false, false, false, false, false, false, false, false]
        webinarFilters = (coder.decodeObject(forKey: "webinarFilters") as? [Bool]) ?? [false, false, false, false, false, false, false, false]
        
        favoritedArticles =  (coder.decodeObject(forKey: "favoritedArticles") as? [Int]) ?? []
        favoritedWebinars = (coder.decodeObject(forKey: "favoritedWebinars") as? [Int]) ?? []
        createdProjects = (coder.decodeObject(forKey: "createdProjects") as? [String]) ?? []
        user_descript = (coder.decodeObject(forKey: "user_descript") as? String) ?? ""
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: "email")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(professionalStatus, forKey: "professionalStatus")
        aCoder.encode(affiliation, forKey: "affiliation")
        aCoder.encode(expertise, forKey: "expertise")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(ageRange, forKey: "ageRange")
        aCoder.encode(articleFilters, forKey: "articleFilters")
        aCoder.encode(webinarFilters, forKey: "webinarFilters")
        aCoder.encode(favoritedArticles, forKey: "favoritedArticles")
        aCoder.encode(favoritedWebinars, forKey: "favoritedWebinars")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(createdProjects, forKey: "createdProjects")
        aCoder.encode(user_descript, forKey: "user_descript")
        
    }
    
    
}
