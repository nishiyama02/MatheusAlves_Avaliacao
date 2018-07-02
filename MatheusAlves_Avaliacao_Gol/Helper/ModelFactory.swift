//
//  ModelFactory.swift
//  MatheusAlves_Avaliacao_Gol
//
//  Created by matheus.n.alves on 01/07/2018.
//  Copyright © 2018 matheus.n.alves. All rights reserved.
//

import Foundation

class ModelFactory{
    
    class func createLocation(fromJson json: NSDictionary) -> Location? {
        if let title = json["title"] as? String,
            let locationType = json["location_type"] as? String,
            let woeId = json["woeid"] as? Int,
            let lattLong = json["latt_long"] as? String{
            return  Location(title, locationType: locationType, woeId: woeId, lattLong: lattLong)
        }
        else{
            return nil
        }
    }
    
    class func createWeather(fromJson json: NSDictionary) -> Weather? {
        
        if let applicationDate = json["applicable_date"] as? String{
            let weather = Weather(applicationDate: applicationDate)
            if let weatherStateName = json["weather_state_name"] as? String{
                weather.weatherStateName = weatherStateName
            }
            if let weatherStateAbbr = json["weather_state_abbr"] as? String{
                weather.weatherStateAbbr = weatherStateAbbr
            }
            if let temp = json["the_temp"] as? Double{
                weather.temp = temp
            }
            if let windSpead = json["wind_speed"] as? Double{
                weather.windSpead = windSpead
            }
            if let windDirection = json["wind_direction"] as? Double{
                weather.windDirection = windDirection
            }
            if let airPressure = json["air_pressure"] as? Double {
                weather.airPressure = airPressure
            }
            if let humidity = json["humidity"] as? Int{
                weather.humidity = humidity
            }
            if let visibility = json["visibility"] as? Double {
                weather.visibility = visibility
            }
            if let predictability = json["predictability"] as? Int{
                weather.predictability = predictability
            }
            if let minTemp = json["min_temp"] as? Double{
                weather.minTemp = minTemp
            }
            if let maxTemp = json["max_temp"] as? Double{
                weather.maxTemp = maxTemp
            }
            if let windDirectionCompass = json["wind_direction_compass"] as? String?{
                weather.windDirectionCompass = windDirectionCompass
            }
            return weather
        }
        else{
            return nil
        }
    }
}
