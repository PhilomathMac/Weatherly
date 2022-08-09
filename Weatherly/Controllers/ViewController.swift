//
//  ViewController.swift
//  Weatherly
//
//  Created by McKenzie Macdonald on 8/8/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var tempUnitLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManger.delegate = self
        
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation()
        
        
        
    }

    
}

// MARK: - TextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    /// Says what to do when return button is pressed. Returns a Bool for if it should process that return.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        if let userText = searchTextField.text {
            print(userText)
        }
        return true
    }
    
    /// Runs when a user tries to deslect the textField. Returns a Bool for if the editing actually ends
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != nil && textField.text != "" {
            textField.placeholder = "Search"
            return true
        } else {
            textField.placeholder = "Enter a city"
            return false
        }
    }
    
    /// Clear textField when user is done editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeatherByName(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        if let userText = searchTextField.text {
            print(userText)
        }
    }
}


// MARK: - WeatherManagerDelegate
extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.tempLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
        
    }
    
    func didFailWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
}

// MARK: - LocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lastLocation = locations.last {
            let lat = lastLocation.coordinate.latitude
            let long = lastLocation.coordinate.longitude
            print(lat)
            print(long)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
