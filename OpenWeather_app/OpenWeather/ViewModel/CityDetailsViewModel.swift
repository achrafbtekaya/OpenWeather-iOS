//
//  CityDetailsViewModel.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import Foundation
import OpenWeatherAPIs

class CityDetailsViewModel {
    var openweather: OpenWeatherAPIs
    
    init() {
        openweather = OpenWeatherAPIs(apiKey: Constants.API_KEY)
    }
    
    func getCityWeatherDetails(latitude: Double, longitude: Double, callback: @escaping (Weather?) -> ()){
        openweather.retreiveWeatherData(latitude, longitude) { result in
            do {
                if (result.error() != nil || result.data() == nil) {
                    callback(nil)
                } else {
                    let jsonData = try JSONSerialization.data(withJSONObject: result.data()!)
                    let weather = try JSONDecoder().decode(Weather.self, from: jsonData)
                    callback(weather)
                }
            } catch let error as NSError {
                print(error)
                callback(nil)
            }
        }
    }

}
