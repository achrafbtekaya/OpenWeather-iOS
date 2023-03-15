//
//  DayForecastTableViewCell.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 15/3/2023.
//

import UIKit

class DayForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var forecastDayDate: UILabel!
    @IBOutlet weak var forecastDayTempMax: UILabel!
    @IBOutlet weak var forecastDayTempMin: UILabel!
    @IBOutlet weak var forecastDayWeatherIcon: UIImageView!
    @IBOutlet weak var forecastDayWeatherTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }

    // This method sets the text of the date label
    func setDateLabel(date: String) {
        forecastDayDate.text = date
    }

    // This method sets the text of the temperature labels
    func setTemperatureLabel(minTemp: Double, maxTemp: Double) {
        self.forecastDayTempMax.text = "/\(Int(minTemp))°" // Set the maximum temperature for the day as the text of a label.
        self.forecastDayTempMin.text = "\(Int(maxTemp))°" // Set the minimum temperature for the day as the text of a label.
    }

    // This method sets the image of the weather icon
    func setWeatherIconImage(iconName: String) {
        forecastDayWeatherIcon.image = UIImage(named: iconName)
    }

    // This method sets the text of the weather title label
    func setWeatherTitleLabel(weatherTitle: String) {
        forecastDayWeatherTitle.text = weatherTitle
    }


}
