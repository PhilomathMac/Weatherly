//
//  WeatherManager.swift
//  Weatherly
//
//  Created by McKenzie Macdonald on 8/8/22.
//

import Foundation

struct WeatherManager {
    
    var cityName = "Cupertino"
    
    let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?units=imperial&appid=\(Constants.openWeatherAPIKey)"
    
    func fetchWeatherByName(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(url: urlString)
    }
    
    func fetchWeatherByLocation(lat: Double, long: Double) {
        let latitudeString = String(lat)
        let longitudeString = String(long)
            
        let urlString = "\(weatherURL)$lat=\(latitudeString)&long=\(longitudeString)"
        
    }
    
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
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            print(decodedData.weather[0].description)
            
        } catch {
            print("error decoding JSON")
            print(error.localizedDescription)
        }
    }
}
