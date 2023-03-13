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
}
