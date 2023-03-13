//
//  CityListViewController.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import UIKit

// MARK: - Main Class
class CityListViewController: UIViewController {
    
    @IBOutlet weak var cityNavigationItem: UINavigationItem!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    var cityListViewModel = CityListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true

        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        
        cityNavigationItem.title = "My Cities"
    }
    
    @IBAction func addCityButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
         alertController.addTextField { (textField : UITextField!) -> Void in
             textField.placeholder = "City Name"
         }
        
         let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
             let firstTextField = alertController.textFields![0] as UITextField
             let cityname = firstTextField.text ?? ""
             print("City Name: \(cityname)")
             
             self.cityListViewModel.getCityInfoFromName(cityName: cityname) { city in
                 if city != nil {
                     let isExist = (Variables.cityList.firstIndex{ $0.id == city!.id } ?? -1) > -1
                     if(!isExist) {
                         Variables.cityList.append(city!)
                         self.cityCollectionView.reloadData()
                     }
                 } else {
                     self.showErrorAlert()
                 }
             }
         })
         let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)


         alertController.addAction(saveAction)
         alertController.addAction(cancelAction)

         self.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        let alertContoller = UIAlertController (title: "Unable to Add City" , message: "An error occurred while adding this city. Please check your city name." , preferredStyle: .alert)
        alertContoller.addAction(UIAlertAction(title: "OK", style:.default , handler: nil))
        self.present(alertContoller , animated: true, completion: nil)
    }
}

// MARK: - Collection View Handler
extension CityListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Variables.cityList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cityCollectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath as IndexPath) as! CityCollectionViewCell
        
        cell.setCityLabel(city: Variables.cityList[indexPath.row].name)
        cell.setCountryLabel(country: Variables.cityList[indexPath.row].sys.country)

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
