//
//  Webinar.swift
//  E4C_app
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation


// Extending NSObject/NSCoding for persistence
class Article: NSObject, NSCoding {
    
    
    
    
    var title : String
    var sector: String = ""
    var content : String
    var imageUrl: String = ""
    var id : Int
    
    
    
    
    
    init(title : String, content : String, id : Int) {
        self.title = title
        self.content = content
        self.id = id
    }
    
    required init? (coder: NSCoder) {
        
        title = (coder.decodeObject(forKey: "title") as? String) ?? ""
        sector = (coder.decodeObject(forKey: "sector") as? String) ?? ""
        imageUrl = (coder.decodeObject(forKey: "imageUrl") as? String) ?? ""
        content = (coder.decodeObject(forKey: "content") as? String) ?? ""
        id = (coder.decodeObject(forKey: "content") as? Int) ?? 0
        
        
    }
    
    func encode(with coder: NSCoder) {
        
        coder.encode(title, forKey: "title")
        coder.encode(sector, forKey: "sector")
        coder.encode(imageUrl, forKey: "imageUrl")
        coder.encode(content, forKey: "content")
        coder.encode(id, forKey: "id")
    }
    
    
    
    
}
