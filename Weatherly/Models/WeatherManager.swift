//
//  WeatherManager.swift
//  Weatherly
//
//  Created by McKenzie Macdonald on 8/8/22.
//

import Foundation

struct WeatherManager {
    let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?units=imperial&appid=\(Constants.openWeatherAPIKey)"
    
    func fetchWeatherByName(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(url: urlString)
    }
    
//    func fetchWeatherByLocation(lat: Double, long: Double) {
//        let latitudeString = String(lat)
//        let longitudeString = String(long)
//
//        let urlString = "\(weatherURL)$lat=\(latitudeString)&long=\(longitudeString)"
//
//    }
    
    func performRequest(url: String) {
        //1. Create a URL
        if let url = URL(string: url) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                
                // 3a. Check for errors
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                
                if let safeData = data {
                    
                    self.parseJSON(weatherData: safeData)
                    
                }
                
                
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        
        //1. Create a decoder
        let decoder = JSONDecoder()
        
        //2. Attempt to decode the data
        do {
            // 2a. Decode the data into a WeatherData type
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            // 2b. Store needed data in constants
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            // 2c. Create WeatherModel object
            let weather = WeatherModel(conditionID: id, cityName: name, temp: temp)
            print(weather.conditionName)
            print(weather.temperatureString)
            
        } catch {
            print("error decoding JSON")
            print(error.localizedDescription)
        }
    }

}
