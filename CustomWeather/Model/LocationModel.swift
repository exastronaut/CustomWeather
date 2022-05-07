//
//  CityModel.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.04.2022.
//

import Foundation

struct LocationData: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}
