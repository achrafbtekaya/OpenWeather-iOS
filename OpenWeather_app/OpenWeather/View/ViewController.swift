//
//  ViewController.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import UIKit
import OpenWeatherAPIs

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let openweather = OpenWeatherAPIs(apiKey: "de79c9827949fa4d24bcdee6a6408c55")
        openweather.retreiveWeatherData(51.5073219, -0.1276474) { result in
            print(result.data())
        }
        // Do any additional setup after loading the view.
    }


}

