//
//  CityCollectionViewCell.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import UIKit

// This is a custom collection view cell class that will display a city name and country name.
class CityCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cityLabel: UILabel! // The outlet for the city name label
    @IBOutlet weak var countryLabel: UILabel! // The outlet for the country name label

    override func awakeFromNib() {
        super.awakeFromNib()
                    
        // Apply a corner radius to the cell
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        
        // Apply a shadow to the cell
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }

    // This method sets the text of the city name label
    func setCityLabel(city: String) {
        cityLabel.text = city
    }

    // This method sets the text of the country name label
    func setCountryLabel(country: String) {
        countryLabel.text = country
    }

}
