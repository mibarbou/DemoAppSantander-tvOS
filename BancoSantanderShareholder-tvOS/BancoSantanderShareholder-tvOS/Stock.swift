//
//  Stock.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 23/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import Foundation


class Stock {
    
    var city = ""
    var currency = ""
    var updateTime = ""
    var changeValue = ""
    var changePercentage = ""
    var stockValue = ""
    
    init(){}
    
    init(city: String, currency: String, updateTime: String, changeValue: String, changePercentage: String, stockValue: String){
        
        self.city = city
        self.currency = currency
        self.updateTime = updateTime
        self.changeValue = changeValue
        self.changePercentage = changePercentage
        self.stockValue = stockValue
        
    }
}