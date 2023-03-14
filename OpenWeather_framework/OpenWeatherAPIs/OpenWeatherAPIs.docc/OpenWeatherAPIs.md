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
public init(apiKey: String, language: String = "en", temperatureFormat: TemperatureFormat = .Celsius, apiVersion: String = "2.5") {
self.apiKey = apiKey
self.temperatureFormat = temperatureFormat
self.apiVersion = apiVersion
self.language = language
}

/**
Retrieves the weather data for the specified city.

Parameters:
latitude: The latitude of the city to retrieve weather data for.
longitude: The longitude of the city to retrieve weather data for.
callback: A callback function to be called with the result of the API request.
*/
open func retreiveWeatherData(_ latitude: Double, _ longitude: Double, callback: @escaping (Result) -> ()) {
call("/onecall?lat=\(latitude)&lon=\(longitude)", callback: callback)
}

/**
Retrieves the latitude and longitude of the specified city.

Parameters:
cityName: The name of the city to retrieve coordinates for.
callback: A callback function to be called with the result of the API request.
*/
open func findCityCoordinates (_ cityName: String, callback: @escaping (Result) -> ()) {
call("/weather?q=(cityName.replaceWhitespace())", callback: callback)
}
