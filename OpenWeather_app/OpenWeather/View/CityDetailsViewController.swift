//
//  CityDetailsViewController.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import UIKit

// Define a class named CityDetailsViewController that inherits from UIViewController
class CityDetailsViewController: UIViewController {
    // Declare two optional variables for the CityDetailsViewModel and an IndexPath instance variable
    var cityDetailsViewModel: CityDetailsViewModel!
    var indexPath: IndexPath!

    // Define outlets for several UI elements in the storyboard
    @IBOutlet weak var cityDetailsNavItem: UINavigationItem!
    @IBOutlet weak var todayWeatherTitle: UILabel!
    @IBOutlet weak var todayWeatherIcon: UIImageView!
    @IBOutlet weak var todayWeatherDescription: UILabel!
    @IBOutlet weak var todayWeatherTemp: UILabel!
    
    
    @IBOutlet weak var twentyFourHourForecastCollectionView: UICollectionView!
    @IBOutlet weak var sevenDaysForecastTableView: UITableView!
    
    
    @IBOutlet weak var realFeelText: UILabel!
    @IBOutlet weak var rainText: UILabel!
    @IBOutlet weak var windText: UILabel!
    @IBOutlet weak var humidityText: UILabel!
    
    
    @IBOutlet weak var todayForecastView: UIView!
    @IBOutlet weak var sevenDayForecastView: UIView!
    @IBOutlet weak var airConditionView: UIView!
    
    var weatherDetails: Weather!

    // Override the viewDidLoad method of UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the large title on the navigation bar
        self.navigationController?.navigationBar.prefersLargeTitles = true

        // Set the title of the navigation bar to the name of the selected city
        cityDetailsNavItem.title = Variables.cityList[self.indexPath.row].name

        // Instantiate the CityDetailsViewModel
        cityDetailsViewModel = CityDetailsViewModel()
                
        // Set up UI elements
        setUpView()
    }
    
    // This function is responsible for setting up the view with the data retrieved from the API.
    // It calls the getCityWeatherDetails function with the latitude and longitude of the selected city from the city list.
    // It fills the UI views with the corresponding data after fetching the data.
    func setUpView() {
        cityDetailsViewModel.getCityWeatherDetails(
            latitude: Variables.cityList[self.indexPath.row].coord.lat,
            longitude: Variables.cityList[self.indexPath.row].coord.lon
        ) { data, error in
            do {
                guard let data = data else {
                    // Display an error alert if the weather details could not be added
                    self.navigationController?.popViewController(animated: true)
                    let errMessage = "Reason : \(data?["message"] ?? "Server not reached. Please try later.")"
                    self.showErrorAlert(message: errMessage)
                    return
                }
                // Tries to decode the response data as a Weather object
                let jsonData = try JSONSerialization.data(withJSONObject: data)
                let weather = try JSONDecoder().decode(Weather.self, from: jsonData)
                self.weatherDetails = weather
                
                // If the weather data is available, it will fill the views with the fetched data.
                self.fillTodayView(weather: weather)
                self.fillTodayForecast(weather: weather)
                self.fillSevenDayForecast(weather: weather)
                self.fillAirCondition(weather: weather)
            } catch {
                let errMessage = "Reason : \(data?["message"] ?? "Server not reached. Please try later.")"
                self.navigationController?.popViewController(animated: true)
                self.showErrorAlert(message: errMessage)
            }
        }
    }

    // This function is responsible for filling the UI views with the data related to today's weather.
    func fillTodayView(weather: Weather) {
        // Fill the weather title label with the current weather condition.
        self.todayWeatherTitle.text = weather.current.weather[0].main
        // Fill the weather icon image view with the current weather icon.
        self.todayWeatherIcon.image = UIImage(named: weather.current.weather[0].icon)
        // Fill the weather description label with the current weather description.
        self.todayWeatherDescription.text = weather.current.weather[0].description
        // Fill the temperature label with the current temperature in Celsius degrees.
        self.todayWeatherTemp.text = "\(Int(weather.current.temp))°"
    }

    // This function is responsible for filling the UI views with the data related to the weather forecast for today.
    func fillTodayForecast(weather: Weather) {
        // Table View Management
        twentyFourHourForecastCollectionView.delegate = self
        twentyFourHourForecastCollectionView.dataSource = self
        twentyFourHourForecastCollectionView.backgroundColor = .clear
        twentyFourHourForecastCollectionView.allowsSelection = false

        // Round the corners of the view that contains the today's forecast information.
        self.todayForecastView.layer.cornerRadius = 10
    }

    // This function takes a Weather object as input and updates the UI with information about the seven-day forecast.
    func fillSevenDayForecast(weather: Weather) {
        // Table View Management
        sevenDaysForecastTableView.delegate = self
        sevenDaysForecastTableView.dataSource = self
        sevenDaysForecastTableView.backgroundColor = .clear

        // Round the corners of the view that contains the 7-day forecast information.
        self.sevenDayForecastView.layer.cornerRadius = 10
    }

    // This function takes in a 'Weather' object as its parameter and fills the air condition data for the UI.
    func fillAirCondition(weather: Weather) {
        // Sets the 'realFeelText' label text to the feels like temperature from the 'Weather' object.
        self.realFeelText.text = "\(Int(weather.current.feelsLike))°"
        // Sets the 'rainText' label text to the amount of rain in the last hour from the 'Weather' object.
        // If 'the1H' value is nil, it sets the text to '0.0' mm.
        self.rainText.text = "\(weather.current.rain?.the1H ?? 0.0) mm"
        // Sets the 'windText' label text to the wind speed from the 'Weather' object.
        self.windText.text = "\(weather.current.windSpeed)"
        // Sets the 'humidityText' label text to the humidity percentage from the 'Weather' object.
        self.humidityText.text = "\(weather.current.humidity)%"
    
        // Sets the corner radius of the 'airConditionView' to 10.
        self.airConditionView.layer.cornerRadius = 10
    }

    // Display an alert to the user when an error occurs while adding a city
    func showErrorAlert(message: String) {
        let alertContoller = UIAlertController(title: "Unable to Load Weather Details", message: message, preferredStyle: .alert)
        alertContoller.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
        self.present(alertContoller, animated: true, completion: nil)
    }

}

extension CityDetailsViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = twentyFourHourForecastCollectionView.dequeueReusableCell(withReuseIdentifier: "HourForecastCell", for: indexPath as IndexPath) as! HourForecastCollectionViewCell //P.S : This forced cast is one of the rare cases where a force cast is welcome. The code must not crash if everything is hooked up correctly. If it does it reveals a design mistake.
        
        // Fill the first hour title label with the time of the first forecasted hour.
        cell.setHourLabel(hour: weatherDetails.hourly[indexPath.row+1].dt.toTime())
        // Fill the first hour icon image view with the icon corresponding to the forecasted weather.
        cell.setWeatherIconImage(iconName: weatherDetails.hourly[indexPath.row+1].weather[0].icon)
        // Fill the first hour temperature label with the temperature in Celsius degrees.
        cell.setTempLabel(temp: weatherDetails.hourly[indexPath.row+1].temp)

        return cell
    }
    
    // This method specifies the size of each cell in the collection view.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: collectionView.bounds.size.height)
    }

    // -------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sevenDaysForecastTableView.dequeueReusableCell(withIdentifier: "DayForecastCell", for: indexPath as IndexPath) as! DayForecastTableViewCell //P.S : This forced cast is one of the rare cases where a force cast is welcome. The code must not crash if everything is hooked up correctly. If it does it reveals a design mistake.
        
        cell.setDateLabel(date: weatherDetails.daily[indexPath.row+1].dt.toDate()) // Convert Unix timestamp to a readable date string and set it as the text of a label.
        cell.setTemperatureLabel(minTemp: weatherDetails.daily[indexPath.row+1].temp.min, maxTemp: weatherDetails.daily[indexPath.row+1].temp.max) // Set the maximum temperature for the day as the text of a label.
        cell.setWeatherIconImage(iconName: weatherDetails.daily[indexPath.row+1].weather[0].icon) // Set the weather icon for the day as the image of an ImageView.
        cell.setWeatherTitleLabel(weatherTitle: weatherDetails.daily[indexPath.row+1].weather[0].main) // Set the weather description for the day as the text of a label.

        return cell
    }
    
    
}
