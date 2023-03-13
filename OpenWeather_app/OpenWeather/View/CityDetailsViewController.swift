//
//  CityDetailsViewController.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import UIKit

class CityDetailsViewController: UIViewController {

    var indexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(self.indexPath.row)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
