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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveCities(_ cityList: [City]) {
        let context = appDelegate.persistentContainer.viewContext
        for city in cityList {
            let newCity = NSEntityDescription.insertNewObject(forEntityName: "Cities", into: context)
            newCity.setValue(city.id, forKey: "id")
            newCity.setValue(city.name, forKey: "name")
            newCity.setValue(city.sys.country, forKey: "country")
            newCity.setValue(city.coord.lat, forKey: "latitude")
            newCity.setValue(city.coord.lon, forKey: "longitude")
        }
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func retrieveSavedCities() -> [City]? {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cities")
        request.returnsObjectsAsFaults = false
        var retrievedCities: [City] = []
        do {
            let results = try context.fetch(request)
            if !results.isEmpty {
                for result in results as! [NSManagedObject] {
                    guard let id = result.value(forKey: "id") as? Int else { return nil }
                    guard let name = result.value(forKey: "name") as? String else { return nil }
                    guard let country = result.value(forKey: "country") as? String else { return nil }
                    guard let latitude = result.value(forKey: "latitude") as? Double else { return nil }
                    guard let longitude = result.value(forKey: "longitude") as? Double else { return nil }
                    let city = City(coord: Coord(lon: longitude, lat: latitude), weather: nil, base: nil, main: nil, visibility: nil, wind: nil, clouds: nil, rain: nil, dt: nil, sys: Sys(country: country, sunrise: nil, sunset: nil), timezone: nil, id: id, name: name, cod: nil)
                    retrievedCities.append(city)
                }
            }
        } catch {
            print("Error retrieving: \(error)")
        }
        return retrievedCities
    }

    func deleteCities() {
        let context = appDelegate.persistentContainer.viewContext
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cities")
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        do {
            let cities = try context.fetch(fetchRequest) as! [NSManagedObject]
            for city in cities {
                context.delete(city)
            }
            // Save Changes
            try context.save()
        } catch {
            // Error Handling
            print("Error retrieving: \(error)")
        }
    }

    
}
