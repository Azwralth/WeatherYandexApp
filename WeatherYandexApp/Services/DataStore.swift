//
//  DataStore.swift
//  WeatherYandexApp
//
//  Created by Владислав Соколов on 24.05.2024.
//

import Foundation


final class DataStore {
    static let shared = DataStore()
    
    var nameCities = [
        "Москва",
        "Санкт-Петербург",
        "Новосибирск",
        "Челябинск",
        "Екатеринбург",
        "Сочи",
        "Лос-Анджелес",
        "Петропавловск-Камчатский",
        "Вена"
    ]
    
    private init() {}
}
