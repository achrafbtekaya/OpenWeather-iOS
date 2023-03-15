//
//  HourForecastCollectionViewCell.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 15/3/2023.
//

import UIKit

class HourForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourTempLabel: UILabel!
    @IBOutlet weak var hourWeatherIcon: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
    }
    
    // This method sets the text of the temperature label
    func setTempLabel(temp: Double) {
        hourTempLabel.text = "\(Int(temp))°"
    }

    // This method sets the text of the hour label
    func setHourLabel(hour: String) {
        self.hourLabel.text = hour // Set the maximum temperature for the day as the text of a label.
    }

    // This method sets the image of the weather icon
    func setWeatherIconImage(iconName: String) {
        hourWeatherIcon.image = UIImage(named: iconName)
    }
    
}
