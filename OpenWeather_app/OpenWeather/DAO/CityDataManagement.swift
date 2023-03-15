//
//  CityDataManagement.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import Foundation
import UIKit
import CoreData

class CityDataManagement {
        
    // This function saves a list of cities to the local persistent store.
    func saveCities(_ cityList: [City]) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {        // Retrieve the managed object context from the app delegate.
            let context = appDelegate.persistentContainer.viewContext
            
            // Loop through each city in the list.
            for city in cityList {
                // Create a new managed object and set its attributes.
                let newCity = NSEntityDescription.insertNewObject(forEntityName: "Cities", into: context)
                newCity.setValue(city.id, forKey: "id")
                newCity.setValue(city.name, forKey: "name")
                newCity.setValue(city.sys.country, forKey: "country")
                newCity.setValue(city.coord.lat, forKey: "latitude")
                newCity.setValue(city.coord.lon, forKey: "longitude")
            }
            
            // Save the changes to the persistent store.
            do {
                try context.save()
                print("Success")
            } catch {
                print("Error saving: \(error)")
            }
        }
    }

    // This function retrieves a list of cities from the local persistent store.
    func retrieveSavedCities() -> [City]? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            // Retrieve the managed object context from the app delegate.
            let context = appDelegate.persistentContainer.viewContext
            
            // Create a fetch request for the "Cities" entity.
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cities")
            request.returnsObjectsAsFaults = false
            
            // Create an empty array to store the retrieved cities.
            var retrievedCities: [City] = []
            
            // Execute the fetch request and loop through each result.
            do {
                if let results = try context.fetch(request) as? [NSManagedObject] {
                    if !results.isEmpty {
                        for result in results {
                            // Retrieve the attributes of the managed object.
                            guard let id = result.value(forKey: "id") as? Int else { return nil }
                            guard let name = result.value(forKey: "name") as? String else { return nil }
                            guard let country = result.value(forKey: "country") as? String else { return nil }
                            guard let latitude = result.value(forKey: "latitude") as? Double else { return nil }
                            guard let longitude = result.value(forKey: "longitude") as? Double else { return nil }
                            
                            // Create a City object from the managed object attributes and append it to the array.
                            let city = City(coord: Coord(lon: longitude, lat: latitude), weather: nil, base: nil, main: nil, visibility: nil, wind: nil, clouds: nil, rain: nil, dt: nil, sys: Sys(country: country, sunrise: nil, sunset: nil), timezone: nil, id: id, name: name, cod: nil)
                            retrievedCities.append(city)
                        }
                    }
                }
            } catch {
                print("Error retrieving: \(error)")
            }
            
            // Return the array of retrieved cities.
            return retrievedCities
        } else {
            return []
        }
    }


    func deleteCities() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            // Retrieve the managed object context from the app delegate.
            let context = appDelegate.persistentContainer.viewContext
            // Initialize Fetch Request
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cities")
            // Configure Fetch Request
            fetchRequest.includesPropertyValues = false
            do {
                if let cities = try context.fetch(fetchRequest) as? [NSManagedObject] {
                    for city in cities {
                        context.delete(city)
                    }
                    // Save Changes
                    try context.save()
                }
            } catch {
                // Error Handling
                print("Error retrieving: \(error)")
            }
        }
    }

    
}
