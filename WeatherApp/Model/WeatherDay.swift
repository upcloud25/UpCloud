//
//  WeatherDay.swift
//  Upcloud
//
//  Created by Joseph on 3/1/19.
//  Copyright © 2019 Joseph. All rights reserved.
//

import SwiftyJSON
import Foundation

class Weather{
    
//http://openweathermap.org/img/w/10d.png
    var temp : Int!
    var temp_min : String!
    var temp_max : String!
    var humidity : String!
    var weather_main: String!
    var weather_description : String!
    var weather_icon: String!
    var clouds : String!
    var wind_speed : String!
    var name: String!
    var country : String!
    var sunset: String!
    var sunrise: String!
    var date : String!
  
    
    init(json: JSON) {
      
        temp = json["main"]["temp"].intValue
        temp_min = json["main"]["temp_min"].stringValue
        temp_max = json["main"]["temp_max"].stringValue
        humidity = json["main"]["humidity"].stringValue
        weather_main = json["weather"][0]["main"].stringValue
        weather_icon = json["weather"][0]["icon"].stringValue
        weather_description = json["weather"][0]["description"].stringValue
        clouds = json["clouds"]["all"].stringValue
        wind_speed = json["wind"]["speed"].stringValue
        name = json["name"].stringValue
        country = json["sys"]["country"].stringValue
        sunrise = UTCToLocal(date: json["sys"]["sunrise"].stringValue , type: "time")
        sunset = UTCToLocal(date: json["sys"]["sunset"].stringValue , type: "time")
        date = UTCToLocal(date: json["dt"].stringValue , type: "date")
        
    }

    
    func UTCToLocal(date:String , type : String) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(date)!)
        let timeFormatter = DateFormatter()
        let dateFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        dateFormatter.dateFormat = "MMM dd yyyy"
        if type == "time" {
        let localDate = timeFormatter.string(from: date as Date)
        return "\(localDate)"
        }else{
            let localDate = dateFormatter.string(from: date as Date)
            return "\(localDate)"
        }
    }
}



