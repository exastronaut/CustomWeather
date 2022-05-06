//
//  CityModel.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.04.2022.
//

import Foundation

struct LocationModel {
    var name: String = ""
    var state: String?
    var country: String = ""
    var lat: Double = 0
    var lon: Double = 0

    func makeModel(_ data: LocatioData) -> [LocationModel] {
        var model = [LocationModel]()
        model.append(LocationModel(name: data.name,
                                   state: data.state,
                                   country: data.country,
                                   lat: data.lat,
                                   lon: data.lon))
        return model
    }
}

struct LocatioData: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}
