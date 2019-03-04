//
//  Countries.swift
//  Upcloud
//
//  Created by Joseph on 3/1/19.
//  Copyright © 2019 Joseph. All rights reserved.
//


import Foundation
import SwiftyJSON

class Countries  {
    
    var name: String!
    var city : String!
    var image : String!
    var code: String!
    
    init(json: JSON) {
        name = json["name"].stringValue
        city = json["capital"].stringValue
        image = json["flag"].stringValue
        code = json["alpha2Code"].stringValue
    }
    
}
var menuItems = ["Cairo" , "London" , "Paris", "Curent Location"]
var tableCountries : [Countries] = []
