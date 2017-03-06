//
//  Movie.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 12/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import Foundation

class Movie {
    
    var url = ""
    var videoId = ""
    var title = ""
    var thumbnail = ""
    var description = ""
    
    init(movieDict: Dictionary<String, AnyObject>) {
     
        if let videoId = movieDict["contentDetails"]!["videoId"] as? String {
            
            self.videoId = videoId
            
        }
        
        if let title = movieDict["snippet"]!["title"] as? String {
            
            self.title = title
        }
        
        if let description = movieDict["snippet"]!["description"] as? String {
            
            self.description = description
        }
        
//        if let thumbnail = movieDict["snippet"]?["thumbnails"]["high"]["url"] as! String {
//            
//            self.thumbnail = thumbnail
//        }
    }
    
    
    init(videoId: String, title: String, url: String, thumbnail: String, description: String){
        
        self.videoId = videoId
        self.title = title
        self.url = url
        self.thumbnail = thumbnail
        self.description = description
        
    }
}
