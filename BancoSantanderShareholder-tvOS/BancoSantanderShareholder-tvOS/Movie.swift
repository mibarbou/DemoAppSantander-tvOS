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
    var title = ""
    var thumbnail = "santander.jpg"
    var description = ""
    
    
    init(title: String, url: String, thumbnail: String, description: String){
        
        self.title = title
        self.url = url
        self.thumbnail = thumbnail
        self.description = description
        
    }
}
