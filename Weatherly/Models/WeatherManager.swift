//
//  WeatherManager.swift
//  Weatherly
//
//  Created by McKenzie Macdonald on 8/8/22.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?units=imperial&appid=\(Constants.openWeatherAPIKey)"
    
    func fetchWeatherByName(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with url: String) {
        //1. Create a URL
        if let url = URL(string: url) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                
                // 3a. Check for errors
                if error != nil {
                    delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let weather = self.parseJSON(safeData) {
                        
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
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
            return WeatherModel(conditionID: id, cityName: name, temp: temp)
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }

}


