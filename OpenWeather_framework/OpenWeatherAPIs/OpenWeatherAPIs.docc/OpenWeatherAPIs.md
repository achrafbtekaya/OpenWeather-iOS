# ``OpenWeatherAPIs``

/**
Framework for fetching weather data from the OpenWeather API.
*/

/**
The API key used to authenticate requests to the OpenWeather API.
*/
open var apiKey: String

/**
The API version used to retrieve weather data.
*/
open var apiVersion: String

/**
The language used for the API response.
*/
open var language: String

/**
The temperature format used for the API response.
*/
open var temperatureFormat: TemperatureFormat

/**
Initializes a new OpenWeatherAPIs instance with the specified API key, language, and temperature format.

Parameters:
apiKey: The API key used to authenticate requests to the OpenWeather API.
language: The language used for the API response.
temperatureFormat: The temperature format used for the API response.
apiVersion: The API version used to retrieve weather data.
*/
public init(apiKey: String, language: String = "fr", temperatureFormat: TemperatureFormat = .Celsius, apiVersion: String = "2.5") {
self.apiKey = apiKey
self.temperatureFormat = temperatureFormat
self.apiVersion = apiVersion
self.language = language
}

/**
Retrieves the current weather data for the specified city.

Parameters:
cityName: The name of the city to retrieve weather data for.
callback: A callback function to be called with the result of the API request.
*/
open func currentWeather(_ cityName: String, callback: @escaping (Result) -> ()) {
call("/weather?q=(cityName.replaceWhitespace())", callback: callback)
}

/**
Retrieves the daily forecast for the specified city.

Parameters:
cityName: The name of the city to retrieve weather data for.
callback: A callback function to be called with the result of the API request.
*/
open func dailyForecast(_ cityName: String, callback: @escaping (Result) -> ()) {
call("/forecast/daily?q=(cityName.replaceWhitespace())", callback: callback)
}

/**
Retrieves the forecast for the specified city.

Parameters:
cityName: The name of the city to retrieve weather data for.
callback: A callback function to be called with the result of the API request.
*/
open func forecast(_ cityName: String, callback: @escaping (Result) -> ()) {
call("/forecast?q=(cityName.replaceWhitespace())", callback: callback)
}

/**
Retrieves the city data for the specified city.

Parameters:
cityName: The name of the city to retrieve data for.
callback: A callback function to be called with the result of the API request.
*/
open func findCity(_ cityName: String, callback: @escaping (Result) -> ()) {
call("/find?q=(cityName.replaceWhitespace())", callback: callback)
}
