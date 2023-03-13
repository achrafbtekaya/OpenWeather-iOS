//
//  CityListViewModel.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import Foundation
import OpenWeatherAPIs

class CityListViewModel {
    var openweather: OpenWeatherAPIs
    
    init() {
        openweather = OpenWeatherAPIs(apiKey: Constants.API_KEY)
    }
    
    func getCityInfoFromName(cityName: String, callback: @escaping (City?) -> ()){
        openweather.findCityCoordinates(cityName) { result in
            do {
                if (result.error() != nil || result.data() == nil) {
                    callback(nil)
                } else {
                    let jsonData = try JSONSerialization.data(withJSONObject: result.data()!)
                    let city = try JSONDecoder().decode(City.self, from: jsonData)
                    callback(city)
                }
            } catch let error as NSError {
                print(error)
                callback(nil)
            }
        }
    }
}
