//
//  CityDetailsViewController.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import UIKit

class CityDetailsViewController: UIViewController {

    var cityDetailsViewModel: CityDetailsViewModel!
    var indexPath: IndexPath!

    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        cityDetailsNavItem.title = Variables.cityList[self.indexPath.row].name
        
        cityDetailsViewModel = CityDetailsViewModel()
        
        setUpView()
    }
    
    func setUpView() {
        cityDetailsViewModel.getCityWeatherDetails(
            latitude: Variables.cityList[self.indexPath.row].coord.lat,
            longitude: Variables.cityList[self.indexPath.row].coord.lon
        ) { weather in
            if weather != nil {
                self.fillTodayView(weather: weather!)
                self.fillTodayForecast(weather: weather!)
                self.fillSevenDayForecast(weather: weather!)
                self.fillAirCondition(weather: weather!)
            } else {
                print("Error : getCityWeatherDetails")
            }
        }
    }
    
    func fillTodayView(weather: Weather) {
        self.todayWeatherTitle.text = weather.current.weather[0].main
        self.todayWeatherIcon.image = UIImage(named: weather.current.weather[0].icon)
        self.todayWeatherDescription.text = weather.current.weather[0].description
        self.todayWeatherTemp.text = "\(Int(weather.current.temp))°"
    }
    
    func fillTodayForecast(weather: Weather) {
        self.firstHourTitle.text = "\(weather.hourly[1].dt.toTime())"
        self.firstHourIcon.image = UIImage(named: weather.hourly[1].weather[0].icon)
        self.firstHourTemp.text = "\(Int(weather.hourly[1].temp))°"

        self.secondHourTitle.text = "\(weather.hourly[4].dt.toTime())"
        self.secondHourIcon.image = UIImage(named: weather.hourly[4].weather[0].icon)
        self.secondHourTemp.text = "\(Int(weather.hourly[4].temp))°"

        self.thirdHourTitle.text = "\(weather.hourly[7].dt.toTime())"
        self.thirdHourIcon.image = UIImage(named: weather.hourly[7].weather[0].icon)
        self.thirdHourTemp.text = "\(Int(weather.hourly[7].temp))°"
        
        self.todayForecastView.layer.cornerRadius = 10
    }

    func fillSevenDayForecast(weather: Weather) {
        self.firstDayDate.text = "\(weather.daily[1].dt.toDate())"
        self.firstTempMax.text = "/\(Int(weather.daily[1].temp.max))°"
        self.firstTempMin.text = "\(Int(weather.daily[1].temp.min))°"
        self.firstDayIcon.image = UIImage(named: weather.daily[1].weather[0].icon)
        self.firstDayTitle.text = "\(weather.daily[1].weather[0].main)"

        self.secondDayDate.text = "\(weather.daily[2].dt.toDate())"
        self.secondTempMax.text = "/\(Int(weather.daily[2].temp.max))°"
        self.secondTempMin.text = "\(Int(weather.daily[2].temp.min))°"
        self.secondDayIcon.image = UIImage(named: weather.daily[2].weather[0].icon)
        self.secondDayTitle.text = "\(weather.daily[2].weather[0].main)"

        self.thirdDayDate.text = "\(weather.daily[3].dt.toDate())"
        self.thirdTempMax.text = "/\(Int(weather.daily[3].temp.max))°"
        self.thirdTempMin.text = "\(Int(weather.daily[3].temp.min))°"
        self.thirdDayIcon.image = UIImage(named: weather.daily[3].weather[0].icon)
        self.thirdDayTitle.text = "\(weather.daily[3].weather[0].main)"
        
        self.forthDayDate.text = "\(weather.daily[4].dt.toDate())"
        self.forthTempMax.text = "/\(Int(weather.daily[4].temp.max))°"
        self.forthTempMin.text = "\(Int(weather.daily[4].temp.min))°"
        self.forthDayIcon.image = UIImage(named: weather.daily[4].weather[0].icon)
        self.forthDayTitle.text = "\(weather.daily[4].weather[0].main)"

        self.fifthDayDate.text = "\(weather.daily[6].dt.toDate())"
        self.fifthTempMax.text = "/\(Int(weather.daily[6].temp.max))°"
        self.fifthTempMin.text = "\(Int(weather.daily[6].temp.min))°"
        self.fifthDayIcon.image = UIImage(named: weather.daily[6].weather[0].icon)
        self.fifthDayTitle.text = "\(weather.daily[6].weather[0].main)"

        self.sixthDayDate.text = "\(weather.daily[5].dt.toDate())"
        self.sixthTempMax.text = "/\(Int(weather.daily[5].temp.max))°"
        self.sixthTempMin.text = "\(Int(weather.daily[5].temp.min))°"
        self.sixthDayIcon.image = UIImage(named: weather.daily[5].weather[0].icon)
        self.sixthDayTitle.text = "\(weather.daily[5].weather[0].main)"

        self.seventhDayDate.text = "\(weather.daily[7].dt.toDate())"
        self.seventhTempMax.text = "/\(Int(weather.daily[7].temp.max))°"
        self.seventhTempMin.text = "\(Int(weather.daily[7].temp.min))°"
        self.seventhDayIcon.image = UIImage(named: weather.daily[7].weather[0].icon)
        self.seventhDayTitle.text = "\(weather.daily[7].weather[0].main)"
        
        self.sevenDayForecastView.layer.cornerRadius = 10
    }

    func fillAirCondition(weather: Weather) {
        self.realFeelText.text = "\(Int(weather.current.feelsLike))°"
        self.rainText.text = "\(weather.current.rain?.the1H ?? 0.0) mm"
        self.windText.text = "\(weather.current.windSpeed)"
        self.humidityText.text = "\(weather.current.humidity)%"

        self.airConditionView.layer.cornerRadius = 10
    }
    
}
