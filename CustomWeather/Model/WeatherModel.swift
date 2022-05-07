//
//  WeatherModel.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 06.04.2022.
//

import Foundation

struct WeatherData: Decodable {
    var list: [List] = []
    var city: City = City()
}

struct Weather: Decodable {
    let description: String
    let icon: String
}

struct City: Decodable {
    var name: String = ""
}

struct List: Decodable {
    let dt: Int
    let main: Main
    let weather: [Weather]
}


struct Main: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
}

