//
//  OpenWeatherAPIs.swift
//  OpenWeatherAPIs
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import Foundation

open class OpenWeatherAPIs {
    public enum TemperatureFormat: String {
        case Celsius = "metric"
        case Fahrenheit = "imperial"
    }
    
    public enum Result {
        case success(URLResponse?, NSDictionary?)
        case Error(URLResponse?, NSError?)
        
        public func data() -> NSDictionary? {
            switch self {
            case .success(_, let dictionary):
                return dictionary
            case .Error(_, _):
                return nil
            }
        }
        
        public func response() -> URLResponse? {
            switch self {
            case .success(let response, _):
                return response
            case .Error(let response, _):
                return response
            }
        }
        
        public func error() -> NSError? {
            switch self {
            case .success(_, _):
                return nil
            case .Error(_, let error):
                return error
            }
        }
    }
    
    open var apiKey: String
    open var apiVersion: String
    open var language: String
    open var temperatureFormat: TemperatureFormat
    
    fileprivate struct Const {
        static let basePath = "http://api.openweathermap.org/data/"
    }
    
    // MARK: - Initialization
    
    public init(apiKey: String, language: String = "fr", temperatureFormat: TemperatureFormat = .Celsius, apiVersion: String = "2.5") {
        self.apiKey = apiKey
        self.temperatureFormat = temperatureFormat
        self.apiVersion = apiVersion
        self.language = language
    }
    
    // MARK: - Retrieving current weather data
    
    open func currentWeather(_ cityName: String, callback: @escaping (Result) -> ()) {
        call("/weather?q=\(cityName.replaceWhitespace())", callback: callback)
    }
    
    // MARK: - Retrieving daily forecast
    
    open func dailyForecast(_ cityName: String, callback: @escaping (Result) -> ()) {
        call("/forecast/daily?q=\(cityName.replaceWhitespace())", callback: callback)
    }
        
    // MARK: - Retrieving forecast
    
    open func forecast(_ cityName: String, callback: @escaping (Result) -> ()) {
        call("/forecast?q=\(cityName.replaceWhitespace())", callback: callback)
    }
    
    // MARK: - Retrieving city
    
    open func findCity(_ cityName: String, callback: @escaping (Result) -> ()) {
        call("/find?q=\(cityName.replaceWhitespace())", callback: callback)
    }
        
    // MARK: - Call api
    
    // This function is used to make an API call with the given method and callback function.
    fileprivate func call(_ method: String, callback: @escaping (Result) -> ()) {
        // Construct the API URL with the given method, API key, language, and temperature format.
        let url = Const.basePath + apiVersion + method + "&APPID=\(apiKey)&lang=\(language)&units=\(temperatureFormat.rawValue)"
        let request = URLRequest(url: URL(string: url)!)
        // Get the current operation queue.
        let currentQueue = OperationQueue.current
        
        // Create a data task with the URLRequest and a completion handler.
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            var error: NSError? = error as NSError?
            var dictionary: NSDictionary?
            
            // If there is data returned, try to deserialize it into an NSDictionary.
            if let data = data {
                do {
                    dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                } catch let e as NSError {
                    error = e
                }
            }
            // Add the callback function to the current operation queue with the appropriate Result object.
            currentQueue?.addOperation {
                var result = Result.success(response, dictionary)
                if error != nil {
                    result = Result.Error(response, error)
                }
                callback(result)
            }
        })
        // Start the data task.
        task.resume()
    }
}

extension String {
    func replace(_ string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string,
            with: replacement,
            options: NSString.CompareOptions.literal,
            range: nil)
    }
    
    func replaceWhitespace() -> String {
        return self.replace(" ", replacement: "+")
    }
}
