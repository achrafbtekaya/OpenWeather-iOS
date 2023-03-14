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
        // Create an instance of the OpenWeatherAPIs class with the API key
        openweather = OpenWeatherAPIs(apiKey: Constants.API_KEY)
    }
    
    // This function retrieves the weather details for a specific city based on its latitude and longitude
    // It uses the OpenWeatherAPIs class to get the weather data
    // The callback function is used to pass the weather data to the view controller
    func getCityWeatherDetails(latitude: Double, longitude: Double, callback: @escaping (Weather?) -> ()) {
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
