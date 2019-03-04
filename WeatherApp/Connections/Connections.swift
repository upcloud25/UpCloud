//
//  Connections.swift
//  Upcloud
//
//  Created by Joseph on 3/1/19.
//  Copyright © 2019 Joseph. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class Connections {
    
    
    public func getAll( completion: @escaping ([Countries]) -> Void ) {
        let url = "https://restcountries.eu/rest/v2/all"
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                var array : [Countries] = []
                let json = JSON(value).arrayValue
                for item in json {
                    let x = Countries(json: item)
                    array.append(x)
                    
                }
                completion(array)
            case .failure(let error):
                print(error)
            }
        }
        
    }

    public func getWeater(city: String , completion: @escaping (Weather?) -> Void ) {
        
    let url = "http://api.openweathermap.org/data/2.5/weather?q=\(city.removingWhitespaces())&APPID=2425717abe18f9acce3870532478dbb9&units=metric"
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let x = Weather(json: json)
                completion(x)
            case .failure(let error):
                print(error)
            }
        }
    
    }
    
    public func getWeaterWithLocation(latitude: String , longitude: String , completion: @escaping (Weather?) -> Void ) {
       print(latitude , longitude)
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=2425717abe18f9acce3870532478dbb9&units=metric"
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let x = Weather(json: json)
                completion(x)
            case .failure(let error):
                print(error)
            }
        }
        
    }



}

extension String {
        func removingWhitespaces() -> String {
            return components(separatedBy: .whitespaces).joined()
        }
}

