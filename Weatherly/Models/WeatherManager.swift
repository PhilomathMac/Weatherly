//
//  WeatherManager.swift
//  Weatherly
//
//  Created by McKenzie Macdonald on 8/8/22.
//

import Foundation

struct WeatherManager {
    
    var cityName = ""
    
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
            
            let condition = getConditionName(weatherID: decodedData.weather[0].id)
            
        } catch {
            print("error decoding JSON")
            print(error.localizedDescription)
        }
    }
    
    func getConditionName(weatherID: Int) -> String {
        switch weatherID {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.heavyrain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...780:
            return "cloud.fog.fill"
        case 781:
            return "tornado"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "?"
        }
    }
}
