//
//  CityCollectionViewCell.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                    
        // Apply a corner radius
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        
        // Apply a shadow
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }

    func setCityLabel(city: String) {
        cityLabel.text = city
    }
    
    func setCountryLabel(country: String) {
        countryLabel.text = country
    }

}
