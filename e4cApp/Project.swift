//
//  Project.swift
//  e4cApp
//
//  Created by Sam on 4/24/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation

// Extending NSObject/NSCoding for persistence
class Project: NSObject, NSCoding {
    
    
    
    
    var title : String
    var sector: String
    var nameAuthor : String
    var projectDescript: String
    var id : String
    var emailAuthor : String
    
    
    
    
    init(title : String, projectDescript : String, id : String, nameAuthor : String, sector: String,
         emailAuthor : String) {
        self.title = title
        self.sector = sector
        self.id = id
        self.nameAuthor = nameAuthor
        self.projectDescript = projectDescript
        self.emailAuthor = emailAuthor
    }
    
    required init? (coder: NSCoder) {
        
        title = (coder.decodeObject(forKey: "title") as? String) ?? ""
        sector = (coder.decodeObject(forKey: "sector") as? String) ?? ""
        nameAuthor = (coder.decodeObject(forKey: "nameAuthor") as? String) ?? ""
        projectDescript = (coder.decodeObject(forKey: "projectDescript") as? String) ?? ""
        id = (coder.decodeObject(forKey: "id") as? String) ?? ""
        emailAuthor = (coder.decodeObject(forKey: "emailAuthor") as? String) ?? ""
        
        
    }
    
    func encode(with coder: NSCoder) {
        
        coder.encode(title, forKey: "title")
        coder.encode(sector, forKey: "sector")
        coder.encode(nameAuthor, forKey: "nameAuthor")
        coder.encode(projectDescript, forKey: "projectDescript")
        coder.encode(id, forKey: "id")
        coder.encode(emailAuthor, forKey: "emailAuthor")
    }
    
    
    
    
}
