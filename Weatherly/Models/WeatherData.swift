//
//  WeatherData.swift
//  Weatherly
//
//  Created by McKenzie Macdonald on 8/8/22.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp : Double
    let feels_like : Double
    let temp_min : Double
    let temp_max : Double
    let humidity : Double
}

struct Weather: Decodable {
    let main: String
    let description: String
}
