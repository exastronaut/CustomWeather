//
//  CityModel.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.04.2022.
//

import Foundation

struct CityModel {
    let name: String
    let temperature: String

    static func makeMockModel() -> [CityModel] {
        var model = [CityModel]()
        model.append(CityModel(name: "Moscow", temperature: "3°"))
        model.append(CityModel(name: "Belgorod", temperature: "10°"))
        model.append(CityModel(name: "Tver", temperature: "1°"))
        return model
    }
}
