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
    var sector: String
    var author: String
    var date: String
    var videoUrl: String
    

    
    
    
    init(title : String, sector: String, author : String, date : String, videoUrl : String) {
        self.title = title
        self.sector = sector
        self.author = author
        self.date = date
        self.videoUrl = videoUrl
    }
    
    required init? (coder: NSCoder) {
        
        title = (coder.decodeObject(forKey: "title") as? String) ?? ""
        sector = (coder.decodeObject(forKey: "sector") as? String) ?? ""
        author = (coder.decodeObject(forKey: "author") as? String) ?? ""
        date = (coder.decodeObject(forKey: "date") as? String) ?? ""
        videoUrl = (coder.decodeObject(forKey: "videoUrl") as? String) ?? ""

        
    }
    func encode(with coder: NSCoder) {
        
        coder.encode(title, forKey: "title")
        coder.encode(sector, forKey: "sector")
        coder.encode(author, forKey: "date")
        coder.encode(date, forKey: "date")
        coder.encode(videoUrl, forKey: "videoUrl")
        
    }
    
    
    
    
}
