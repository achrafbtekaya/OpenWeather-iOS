//
//  City.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import Foundation

// MARK: - City
struct City: Codable {
    let coord: Coord
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys
    let timezone: Int?
    let id: Int
    let name: String
    let cod: Int?

    enum CodingKeys: String, CodingKey {
        case coord, weather, base, main, visibility, wind, rain, clouds, dt, sys, timezone, id, name, cod
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon: Double
    let lat: Double
}

