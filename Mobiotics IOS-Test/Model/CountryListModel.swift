//
//  CountryListModel.swift
//  Mobiotics IOS-Test
//
//  Created by Suraj on 27/09/18.
//  Copyright © 2018 Suraj. All rights reserved.
//

import Foundation

class CountryListModel:NSObject,NSCoding{
    
    var countryName:String = ""
    var countryLastName:String = ""
    var email:String = ""
    var phoneNumber:String = ""
    var countryCode:String = ""
    var image:String = ""
    
    init(countryName:String,countryLastName:String,email:String,phoneNumber:String,countryCode:String,image:String) {
        
        self.countryName = countryName
        self.countryLastName = countryLastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.countryCode = countryCode
        self.image = image
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.countryName, forKey: "countryName")
        aCoder.encode(countryLastName, forKey: "countryLastName")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.phoneNumber, forKey: "phoneNumber")
        aCoder.encode(self.countryCode, forKey: "countryCode")
        aCoder.encode(self.image, forKey: "image")
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.countryName = aDecoder.decodeObject(forKey: "countryName") as! String
        self.countryLastName = aDecoder.decodeObject(forKey: "countryLastName") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as! String
        self.countryCode = aDecoder.decodeObject(forKey: "countryCode") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! String
        
        
    }
    
    
}
