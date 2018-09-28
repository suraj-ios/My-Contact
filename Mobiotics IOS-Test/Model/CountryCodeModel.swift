//
//  CountryCodeModel.swift
//  Mobiotics IOS-Test
//
//  Created by Suraj on 27/09/18.
//  Copyright © 2018 Suraj. All rights reserved.
//

import Foundation
class CountryCodeModel {
    
    var countryName:String = ""
    var countryShortCode:String = ""
    var countryCode:String = ""
    
    
    init(countryName:String,countryShortCode:String,countryCode:String) {
        
        self.countryName = countryName
        self.countryCode = countryCode
        self.countryShortCode = countryShortCode
        
        
    }
    
}
