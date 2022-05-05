//
//  WeatherModel.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 06.04.2022.
//

import Foundation

struct WeatherModel {
    var name: String = "Название"
    var temp: Double = 0
    var icon: String = ""
    var description: String = ""

    func makeListModel(_ data: WeatherData) -> [WeatherModel] {
        var result = [WeatherModel]()
        result.append(WeatherModel(name: data.city.name, temp: data.list.first!.main.temp))
        return result
    }

    func makeModel(_ data: WeatherData) -> WeatherModel {
        WeatherModel(name: data.city.name, temp: data.list.first!.main.temp)
    }
}

struct WeatherData: Decodable {
    let list: [List]
    let city: City
}

struct City: Decodable {
    let name: String
    let country: String
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct List: Decodable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dtTxt: String
    let rain: Rain?
}

struct Clouds: Decodable {
    let all: Int
}

struct Main: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let seaLevel: Int
    let grndLevel: Int
    let humidity: Int
    let tempKf: Double
}

struct Rain: Decodable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct Sys: Decodable {
    let pod: String
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
}
