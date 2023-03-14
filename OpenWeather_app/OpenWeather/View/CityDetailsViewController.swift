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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        cityDetailsNavItem.title = Variables.cityList[self.indexPath.row].name
        
        cityDetailsViewModel = CityDetailsViewModel()
    }
    
    func setUpView() {
        cityDetailsViewModel.getCityWeatherDetails(
            latitude: Variables.cityList[self.indexPath.row].coord.lat,
            longitude: Variables.cityList[self.indexPath.row].coord.lon
        ) { weather in
            if weather != nil {
                self.fillTodayView(weather: weather!)
            } else {
                print("Error : getCityWeatherDetails")
            }
        }
    }
    
    func fillTodayView(weather: Weather) {
        self.todayWeatherTitle.text = weather.current.weather[0].main
        self.todayWeatherIcon.image = UIImage(named: weather.current.weather[0].icon)
        self.todayWeatherDescription.text = weather.current.weather[0].description
        self.todayWeatherTemp.text = "\(weather.current.temp)"
    }
    
}
