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
    @IBOutlet weak var firstHourTitle: UILabel!
    @IBOutlet weak var firstHourTemp: UILabel!
    @IBOutlet weak var firstHourIcon: UIImageView!
    @IBOutlet weak var secondHourIcon: UIImageView!
    @IBOutlet weak var secondHourTitle: UILabel!
    @IBOutlet weak var secondHourTemp: UILabel!
    @IBOutlet weak var thirdHourTitle: UILabel!
    @IBOutlet weak var thirdHourIcon: UIImageView!
    @IBOutlet weak var thirdHourTemp: UILabel!
    @IBOutlet weak var firstDayDate: UILabel!
    @IBOutlet weak var firstTempMax: UILabel!
    @IBOutlet weak var firstTempMin: UILabel!
    @IBOutlet weak var firstDayIcon: UIImageView!
    @IBOutlet weak var firstDayTitle: UILabel!
    @IBOutlet weak var secondDayDate: UILabel!
    @IBOutlet weak var secondTempMax: UILabel!
    @IBOutlet weak var secondTempMin: UILabel!
    @IBOutlet weak var secondDayIcon: UIImageView!
    @IBOutlet weak var secondDayTitle: UILabel!
    @IBOutlet weak var thirdDayDate: UILabel!
    @IBOutlet weak var thirdTempMax: UILabel!
    @IBOutlet weak var thirdTempMin: UILabel!
    @IBOutlet weak var thirdDayIcon: UIImageView!
    @IBOutlet weak var thirdDayTitle: UILabel!
    @IBOutlet weak var forthDayDate: UILabel!
    @IBOutlet weak var forthTempMax: UILabel!
    @IBOutlet weak var forthTempMin: UILabel!
    @IBOutlet weak var forthDayIcon: UIImageView!
    @IBOutlet weak var forthDayTitle: UILabel!
    @IBOutlet weak var fifthDayDate: UILabel!
    @IBOutlet weak var fifthTempMax: UILabel!
    @IBOutlet weak var fifthTempMin: UILabel!
    @IBOutlet weak var fifthDayIcon: UIImageView!
    @IBOutlet weak var fifthDayTitle: UILabel!
    @IBOutlet weak var sixthDayDate: UILabel!
    @IBOutlet weak var sixthTempMax: UILabel!
    @IBOutlet weak var sixthTempMin: UILabel!
    @IBOutlet weak var sixthDayIcon: UIImageView!
    @IBOutlet weak var sixthDayTitle: UILabel!
    @IBOutlet weak var seventhDayDate: UILabel!
    @IBOutlet weak var seventhTempMax: UILabel!
    @IBOutlet weak var seventhTempMin: UILabel!
    @IBOutlet weak var seventhDayIcon: UIImageView!
    @IBOutlet weak var seventhDayTitle: UILabel!
    @IBOutlet weak var realFeelText: UILabel!
    @IBOutlet weak var rainText: UILabel!
    @IBOutlet weak var windText: UILabel!
    @IBOutlet weak var humidityText: UILabel!
    @IBOutlet weak var todayForecastView: UIView!
    @IBOutlet weak var sevenDayForecastView: UIView!
    @IBOutlet weak var airConditionView: UIView!

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
        ) { weather in
            if weather != nil {
                // If the weather data is available, it will fill the views with the fetched data.
                self.fillTodayView(weather: weather!)
                self.fillTodayForecast(weather: weather!)
                self.fillSevenDayForecast(weather: weather!)
                self.fillAirCondition(weather: weather!)
            } else {
                // If there is an error while fetching the data, it will print an error message.
                print("Error : getCityWeatherDetails")
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
        // Fill the first hour title label with the time of the first forecasted hour.
        self.firstHourTitle.text = "\(weather.hourly[1].dt.toTime())"
        // Fill the first hour icon image view with the icon corresponding to the forecasted weather.
        self.firstHourIcon.image = UIImage(named: weather.hourly[1].weather[0].icon)
        // Fill the first hour temperature label with the temperature in Celsius degrees.
        self.firstHourTemp.text = "\(Int(weather.hourly[1].temp))°"

        // Fill the second hour title label with the time of the second forecasted hour.
        self.secondHourTitle.text = "\(weather.hourly[4].dt.toTime())"
        // Fill the second hour icon image view with the icon corresponding to the forecasted weather.
        self.secondHourIcon.image = UIImage(named: weather.hourly[4].weather[0].icon)
        // Fill the second hour temperature label with the temperature in Celsius degrees.
        self.secondHourTemp.text = "\(Int(weather.hourly[4].temp))°"

        // Fill the third hour title label with the time of the third forecasted hour.
        self.thirdHourTitle.text = "\(weather.hourly[7].dt.toTime())"
        // Fill the third hour icon image view with the icon corresponding to the forecasted weather.
        self.thirdHourIcon.image = UIImage(named: weather.hourly[7].weather[0].icon)
        // Fill the third hour temperature label with the temperature in Celsius degrees.
        self.thirdHourTemp.text = "\(Int(weather.hourly[7].temp))°"

        // Round the corners of the view that contains the today's forecast information.
        self.todayForecastView.layer.cornerRadius = 10
    }

    // This function takes a Weather object as input and updates the UI with information about the seven-day forecast.
    func fillSevenDayForecast(weather: Weather) {
        // Update the UI with information about the first day in the forecast.
        self.firstDayDate.text = "\(weather.daily[1].dt.toDate())" // Convert Unix timestamp to a readable date string and set it as the text of a label.
        self.firstTempMax.text = "/\(Int(weather.daily[1].temp.max))°" // Set the maximum temperature for the day as the text of a label.
        self.firstTempMin.text = "\(Int(weather.daily[1].temp.min))°" // Set the minimum temperature for the day as the text of a label.
        self.firstDayIcon.image = UIImage(named: weather.daily[1].weather[0].icon) // Set the weather icon for the day as the image of an ImageView.
        self.firstDayTitle.text = "\(weather.daily[1].weather[0].main)" // Set the weather description for the day as the text of a label.

        // Update the UI with information about the second day in the forecast.
        self.secondDayDate.text = "\(weather.daily[2].dt.toDate())"
        self.secondTempMax.text = "/\(Int(weather.daily[2].temp.max))°"
        self.secondTempMin.text = "\(Int(weather.daily[2].temp.min))°"
        self.secondDayIcon.image = UIImage(named: weather.daily[2].weather[0].icon)
        self.secondDayTitle.text = "\(weather.daily[2].weather[0].main)"

        // Update the UI with information about the third day in the forecast.
        self.thirdDayDate.text = "\(weather.daily[3].dt.toDate())"
        self.thirdTempMax.text = "/\(Int(weather.daily[3].temp.max))°"
        self.thirdTempMin.text = "\(Int(weather.daily[3].temp.min))°"
        self.thirdDayIcon.image = UIImage(named: weather.daily[3].weather[0].icon)
        self.thirdDayTitle.text = "\(weather.daily[3].weather[0].main)"

        // Update the UI with information about the fourth day in the forecast.
        self.forthDayDate.text = "\(weather.daily[4].dt.toDate())"
        self.forthTempMax.text = "/\(Int(weather.daily[4].temp.max))°"
        self.forthTempMin.text = "\(Int(weather.daily[4].temp.min))°"
        self.forthDayIcon.image = UIImage(named: weather.daily[4].weather[0].icon)
        self.forthDayTitle.text = "\(weather.daily[4].weather[0].main)"

        // Update the UI with information about the fifth day in the forecast.
        self.fifthDayDate.text = "\(weather.daily[6].dt.toDate())"
        self.fifthTempMax.text = "/\(Int(weather.daily[6].temp.max))°"
        self.fifthTempMin.text = "\(Int(weather.daily[6].temp.min))°"
        self.fifthDayIcon.image = UIImage(named: weather.daily[6].weather[0].icon)
        self.fifthDayTitle.text = "\(weather.daily[6].weather[0].main)"

        // Update the UI with information about the sixth day in the forecast.
        self.sixthDayDate.text = "\(weather.daily[5].dt.toDate())"
        self.sixthTempMax.text = "/\(Int(weather.daily[5].temp.max))°"
        self.sixthTempMin.text = "\(Int(weather.daily[5].temp.min))°"
        self.sixthDayIcon.image = UIImage(named: weather.daily[5].weather[0].icon)
        self.sixthDayTitle.text = "\(weather.daily[5].weather[0].main)"
        
        // Update the UI with information about the seventh day in the forecast.
        self.seventhDayDate.text = "\(weather.daily[7].dt.toDate())"
        self.seventhTempMax.text = "/\(Int(weather.daily[7].temp.max))°"
        self.seventhTempMin.text = "\(Int(weather.daily[7].temp.min))°"
        self.seventhDayIcon.image = UIImage(named: weather.daily[7].weather[0].icon)
        self.seventhDayTitle.text = "\(weather.daily[7].weather[0].main)"
        
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




}
