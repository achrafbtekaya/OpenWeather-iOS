//
//  Weather.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import Foundation

// MARK: - Location
struct Location: Codable {
    let lon: Double
    let lat: Double
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int

    private enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

// MARK: - Rain
struct Rain: Codable {
    let oneHour: Double

    private enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Sys
struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String
    let sunrise: Int?
    let sunset: Int?
}

// MARK: - WeatherData
struct WeatherData: Codable {
    let coord: Location
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}
