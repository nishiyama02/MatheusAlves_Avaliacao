//
//  Weather.swift
//  MatheusAlves_Avaliacao_Gol
//
//  Created by matheus.n.alves on 01/07/2018.
//  Copyright © 2018 matheus.n.alves. All rights reserved.
//

import Foundation

class Weather {
    
    var weatherStateName: String?
    var weatherStateAbbr: String?
    var windDirectionCompass: String?
//    var applicationDate: String?
    var minTemp: Double?
    var maxTemp: Double?
    var temp: Double?
    var windSpead: Double?
    var windDirection: Double?
    var airPressure: Double?
    var humidity: Int?
    var visibility: Double?
    var predictability: Int?

    
    init(weatherStateName: String?, weatherStateAbbr: String?, temp: Double?) {
        self.weatherStateName = weatherStateName
        self.weatherStateAbbr = weatherStateAbbr
        self.temp = temp
    }
    
}
