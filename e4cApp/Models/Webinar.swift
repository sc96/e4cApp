//
//  Webinar.swift
//  E4C_app
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation


// Extending NSObject/NSCoding for persistence
class Webinar: NSObject, NSCoding {
    

    
    
    var title : String
    var sector: String = ""
    var content : String
    var id : Int
    var videoUrl: String = "wwww.googe.com"
    

    
    
    
    init(title : String, content : String, id : Int) {
        self.title = title
        self.id = id
        self.content = content
    }
    
    required init? (coder: NSCoder) {
        
        title = (coder.decodeObject(forKey: "title") as? String) ?? ""
        sector = (coder.decodeObject(forKey: "sector") as? String) ?? ""
        videoUrl = (coder.decodeObject(forKey: "videoUrl") as? String) ?? ""
        id = (coder.decodeObject(forKey: "id") as? Int) ?? 0
        content = (coder.decodeObject(forKey: "content") as? String) ?? ""

        
    }
    func encode(with coder: NSCoder) {
        
        coder.encode(title, forKey: "title")
        coder.encode(sector, forKey: "sector")
        coder.encode(videoUrl, forKey: "videoUrl")
        coder.encode(id, forKey: "id")
        coder.encode(content, forKey : "content")
        
        
    }
    
    
    
    
}
