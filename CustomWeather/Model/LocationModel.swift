//
//  CityModel.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.04.2022.
//

import Foundation

struct LocationModel {
    let name: String
    let temperature: String

    static func makeMockModel() -> [LocationModel] {
        var model = [LocationModel]()
        model.append(LocationModel(name: "Moscow", temperature: "3"))
        model.append(LocationModel(name: "Belgorod", temperature: "10"))
        model.append(LocationModel(name: "Tver", temperature: "1"))
        return model
    }
}
