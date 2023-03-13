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
    var cityDAO: CityDataManagement
    
    init() {
        openweather = OpenWeatherAPIs(apiKey: Constants.API_KEY)
        cityDAO = CityDataManagement()
        Variables.cityList = cityDAO.retrieveSavedCities() ?? []
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
    
    func addNewCity(city: City) {
        let isExist = (Variables.cityList.firstIndex{ $0.id == city.id } ?? -1) > -1
        if(!isExist) {
            cityDAO.deleteCities()
            Variables.cityList.append(city)
            cityDAO.saveCities(Variables.cityList)
        }
    }
}
