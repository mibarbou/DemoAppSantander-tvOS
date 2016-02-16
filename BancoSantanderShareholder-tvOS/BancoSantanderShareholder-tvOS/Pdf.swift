//
//  Pdf.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 12/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import Foundation

class Pdf {
    
    var docname = ""
    var url = ""
    var title = ""
    var size = "0"
    var icon = "santander.jpg"
    
    init(){} 
    
    init(docname:String, title: String, url: String, size: String, icon: String){
        
        self.docname = docname
        self.title = title
        self.url = url
        self.size = size
        self.icon = icon
        
    }
    
}
