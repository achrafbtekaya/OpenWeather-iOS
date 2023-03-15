//
//  CityListViewController.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import UIKit

// MARK: - Main Class
// The CityListViewController is responsible for managing the list of cities in the app, displaying them in a collection view,
// and allowing the user to add new cities.

class CityListViewController: UIViewController {
    // Outlets for the UI elements in the view
    @IBOutlet weak var cityNavigationItem: UINavigationItem!
    @IBOutlet weak var cityCollectionView: UICollectionView!

    // ViewModel for managing the city data and API requests
    var cityListViewModel: CityListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation bar
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Initialize the city list view model
        cityListViewModel = CityListViewModel()
        
        // Configure collection view
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        
        // Set the title of the navigation item
        cityNavigationItem.title = "My Cities"
    }

    // Handle user tapping the "Add City" button
    @IBAction func addCityButton(_ sender: Any) {
        // Create an alert controller to prompt the user for the city name
        let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "City Name"
        }
        
        // Define the "Add" and "Cancel" actions for the alert
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            // Get the entered city name
            let firstTextField = alertController.textFields![0] as UITextField
            let cityname = firstTextField.text ?? ""
            print("City Name: \(cityname)")
            
            // Use the city list view model to get information about the city and add it to the list
            self.cityListViewModel.getCityInfoFromName(cityName: cityname) { data, error in
                do {
                    guard let data = data else {
                        // Display an error alert if the city could not be added
                        let errMessage = "Reason : \(data?["message"] ?? "Server not reached. Please try later.")"
                        self.showErrorAlert(message: errMessage)
                        return
                    }
                    // Tries to decode the response data as a City object
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let city = try JSONDecoder().decode(City.self, from: jsonData)
                    
                    self.cityListViewModel.addNewCity(city: city)
                    self.cityCollectionView.reloadData()
                } catch {
                    print(error)
                    let errMessage = "Reason : \(data?["message"] ?? "Server not reached. Please try later.")"
                    self.showErrorAlert(message: errMessage)
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        // Add the actions to the alert controller
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        // Present the alert controller to the user
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Display an alert to the user when an error occurs while adding a city
    func showErrorAlert(message: String) {
        let alertContoller = UIAlertController(title: "Unable to Add City", message: message, preferredStyle: .alert)
        alertContoller.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
        self.present(alertContoller, animated: true, completion: nil)
    }

    // Handle the segue to the CityDetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWeatherDetails", let dest = segue.destination as? CityDetailsViewController, let cell = sender as? UICollectionViewCell {
            dest.indexPath = self.cityCollectionView.indexPath(for: cell)!
        }
    }
}

// MARK: - Collection View Handler
extension CityListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Return the number of cities in the list
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Variables.cityList.count
    }

    // This method is responsible for setting up the city cells in the collection view.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cityCollectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath as IndexPath) as! CityCollectionViewCell //P.S : This forced cast is one of the rare cases where a force cast is welcome. The code must not crash if everything is hooked up correctly. If it does it reveals a design mistake.
        
        // Set the name of the city in the cell.
        cell.setCityLabel(city: Variables.cityList[indexPath.row].name)
        // Set the country name of the city in the cell.
        cell.setCountryLabel(country: Variables.cityList[indexPath.row].sys.country)

        return cell
    }

    // This method specifies the number of sections in the collection view.
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }

    // This method specifies the size of each cell in the collection view.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 65)
    }

    // This method is called when a city cell is selected in the collection view.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Perform segue to the CityDetailsViewController when a cell is selected.
        self.performSegue(withIdentifier: "ShowWeatherDetails", sender: collectionView.cellForItem(at: indexPath))
        // Deselect the selected cell to avoid multiple selection.
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
