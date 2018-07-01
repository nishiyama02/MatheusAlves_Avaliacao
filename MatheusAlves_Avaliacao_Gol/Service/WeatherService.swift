//
//  WeatherService.swift
//  MatheusAlves_Avaliacao_Gol
//
//  Created by matheus.n.alves on 01/07/2018.
//  Copyright © 2018 matheus.n.alves. All rights reserved.
//

import Foundation
import Alamofire

class WeatherService{
    
    static let instance = WeatherService()
    private let ENDPOINT = "https://www.metaweather.com/"
    private let sessionManager: SessionManager
    private let userDefault: UserDefaults
    private var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url!.appendingPathComponent("Data").path)
    }
    
    init() {
        let configuration = URLSessionConfiguration.default
        sessionManager = Alamofire.SessionManager(configuration: configuration)
        userDefault = UserDefaults.standard
    }
    
    func getLocations(withSearchName searchText: String,
                      getCitiesHandler: @escaping (Bool, [Location]?, String?)->()){
        let url = String.init(format: "%@api/location/search/?query=%@", ENDPOINT, searchText)
        sessionManager.request(url).validate().responseJSON {
            (response) in
            switch response.result{
            case .success(let data):
                if let array = data as? [Any] {
                    var locations = Array<Location>()
                    for value in array{
                        if let json = value as? NSDictionary{
                            if let location = ModelFactory.createLocation(fromJson: json) {
                                if location.isTitleStarted(withText: searchText)
                                {
                                    locations.append(location)
                                }
                            }
                        }
                    }
                    getCitiesHandler(true, locations, nil);
                }
                else{
                    getCitiesHandler(false, nil, "Failed to get response");
                }
                break
            case .failure :
                break
            }
        }
    }
    
    func getWeatherDetail(withWoeId woeId: Int, getWeatherDetailHandler: @escaping (Bool, [Weather]?, String?)->()){
        let url = String.init(format: "%@api/location/location/%@", ENDPOINT, woeId.description)
        sessionManager.request(url).validate().responseJSON {
            (response) in
            switch response.result{
            case .success(let data):
                if let json = data as? NSDictionary,
                    let consolidated_weathers = json["consolidated_weather"] as? [NSDictionary]{
                    var weathers = Array<Weather>()
                    for consolidatedWeather in consolidated_weathers{
                        if let weather = ModelFactory.createWeather(fromJson: consolidatedWeather)
                        {
                            weathers.append(weather)
                        }
                    }
                    getWeatherDetailHandler(true, weathers, nil)
                }
                else{
                    getWeatherDetailHandler(false, nil, "Failed to get weather detail")
                }
                break
            case .failure :
                getWeatherDetailHandler(false, nil, "Failed to get response")
                break
            }
        }
    }
    
    func getWeahterStateIcon(withWeatherState weatherState: String, handler: @escaping (Bool, UIImage?, String?)-> ())
    {
        let url = String.init(format: "%@static/img/weather/png/%@.png", ENDPOINT, weatherState)
        sessionManager.request(url).validate().responseData { (response) in
            switch response.result{
            case .success(let data):
                let image = UIImage.init(data: data)
                handler(true, image, nil)
                break
            case .failure:
                handler(false, nil, "Failed to load image")
                break
            }
        }
    }
    
}
