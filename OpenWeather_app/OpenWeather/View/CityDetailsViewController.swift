//
//  CityDetailsViewController.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import UIKit

class CityDetailsViewController: UIViewController {

    @IBOutlet weak var cityDetailsNavItem: UINavigationItem!
    
    var indexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        cityDetailsNavItem.title = Variables.cityList[self.indexPath.row].name
    }
    

}
