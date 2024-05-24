//
//  Weather.swift
//  WeatherYandexApp
//
//  Created by Владислав Соколов on 22.05.2024.
//


import Foundation

struct WeatherData: Decodable {
    let now_dt: String
    let info: Info
    let fact: Fact
}

struct Info: Decodable {
    let url: String
}

struct Fact: Decodable {
    let temp: Double
    let icon: String
    let condition: String
    let windSpeed: Double
    let pressureMm: Double
    let humidity: Double
    let windDir: String
    
    enum CodingKeys: String, CodingKey {
        case temp
        case icon
        case condition
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
        case humidity
        case windDir = "wind_dir"
    }
}
