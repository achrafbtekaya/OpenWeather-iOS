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
    
    // Initializes an instance of CityListViewModel
    init() {
        // Creates an instance of OpenWeatherAPIs with an API key
        openweather = OpenWeatherAPIs(apiKey: Constants.API_KEY)
        // Creates an instance of CityDataManagement for data access
        cityDAO = CityDataManagement()
        // Sets the city list in Variables to the retrieved saved cities from CityDataManagement, or an empty array if no cities are saved
        Variables.cityList = cityDAO.retrieveSavedCities() ?? []
    }
    
    // Gets the city information from its name
    func getCityInfoFromName(cityName: String, callback: @escaping (City?) -> ()){
        openweather.findCityCoordinates(cityName) { result in
            do {
                // If the API request was unsuccessful, the callback returns nil
                if (result.error() != nil || result.data() == nil) {
                    callback(nil)
                } else {
                    // Tries to decode the response data as a City object
                    let jsonData = try JSONSerialization.data(withJSONObject: result.data()!)
                    let city = try JSONDecoder().decode(City.self, from: jsonData)
                    // If successful, the callback returns the City object
                    callback(city)
                }
            } catch let error as NSError {
                // If an error occurred during decoding, the callback returns nil
                print(error)
                callback(nil)
            }
        }
    }
    
    // Adds a new city to the city list
    func addNewCity(city: City) {
        // Checks if the city is already in the city list
        let isExist = (Variables.cityList.firstIndex{ $0.id == city.id } ?? -1) > -1
        if(!isExist) {
            // Deletes all saved cities from Core Data, adds the new city to the city list, and saves the updated list to Core Data
            cityDAO.deleteCities()
            Variables.cityList.append(city)
            cityDAO.saveCities(Variables.cityList)
        }
    }
}

