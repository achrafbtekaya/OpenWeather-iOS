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
    
    func getCityInfoFromName(cityName: String){
        openweather.findCityCoordinates(cityName) { result in
            do {
                if (result.error() != nil || result.data() == nil){ //|| (result.data() as City) != 200) {
                    print("error")
                } else {
                    let city = try JSONDecoder().decode(City.self, from: result.data()!)

                    print(result.data())
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
}
