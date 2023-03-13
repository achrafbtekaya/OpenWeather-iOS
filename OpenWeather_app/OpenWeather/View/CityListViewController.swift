//
//  CityListViewController.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import UIKit
import OpenWeatherAPIs

// MARK: - Main Class
class CityListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var cityNavigationItem: UINavigationItem!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        
        cityNavigationItem.title = "My Cities"

        let openweather = OpenWeatherAPIs(apiKey: Constants.API_KEY)
        openweather.retreiveWeatherData(51.5073219, -0.1276474) { result in
            print(result.data())
        }
        // Do any additional setup after loading the view.
    }
}

// MARK: - Collection View Handler
extension CityListViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cityCollectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath as IndexPath) as! CityCollectionViewCell
        
        cell.setCityLabel(city: "Paris")
        cell.setCountryLabel(country: "FR")

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.bounds.size.width, height: 65)
    }
}
