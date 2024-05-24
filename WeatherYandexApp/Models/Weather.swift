//
//  Weather.swift
//  WeatherYandexApp
//
//  Created by Владислав Соколов on 23.05.2024.
//

import Foundation

struct Weather {
    var name = "Название"
    var now_dt = ""
    var temperature = 0.0
    var conditionCode = ""
    var url = ""
    var condition = ""
    var windDir = ""
    var pressureMm = 0.0
    var windSpeed = 0.0
    var humidity = 0.0
    
    var conditionString: String {
        switch condition {
        case "clear":
            return "ясно"
        case "partly-cloudy":
            return "малооблачно"
        case "cloudy":
            return "облачно с прояснениями"
        case "overcast":
            return "пасмурно"
        case "light-rain":
            return "небольшой дождь"
        case "rain":
            return "дождь"
        case "heavy-rain":
            return "сильный дождь"
        case "showers":
            return "ливень"
        case "wet-snow":
            return "дождь со снегом"
        case "light-snow":
            return "небольшой снег"
        case "snow":
            return "снег"
        case "snow-showers":
            return "снегопад"
        case "hail":
            return "град"
        case "thunderstorm":
            return "гроза"
        case "thunderstorm-with-rain":
            return "дождь с грозой"
        case "thunderstorm-with-hail":
            return "гроза с градом"
        default:
            return "Идет загрузка..."
        }
    }
    
    var windDirectionString: String {
        switch windDir {
        case "nw":
            return "северо-западный"
        case "n":
            return "северный"
        case "ne":
            return "северо-восточный"
        case "e":
            return "восточный"
        case "se":
            return "юго-восточный"
        case "s":
            return "южный"
        case "sw":
            return "юго-западный"
        case "w":
            return "западный"
        case "c":
            return "штиль"
        default:
            return "неизвестное направление"
        }
    }
    
    init(weatherData: WeatherData) {
        temperature = weatherData.fact.temp
        now_dt = weatherData.now_dt
        conditionCode = weatherData.fact.icon
        url = weatherData.info.url
        condition = weatherData.fact.condition
        pressureMm = weatherData.fact.pressureMm
        windSpeed = weatherData.fact.windSpeed
        humidity = weatherData.fact.humidity
        windDir = weatherData.fact.windDir
    }
    
    init() {}
    
    // Метод для форматирования даты
    func formattedDate() -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        inputDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = inputDateFormatter.date(from: now_dt) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "d MMMM"
            outputDateFormatter.locale = Locale(identifier: "ru_RU")
            return outputDateFormatter.string(from: date)
        } else {
            print("Invalid date format: \(now_dt)")
            return "Неверная дата"
        }
    }
    
    // Метод для определения времени суток
    func timeOfDay() -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        inputDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = inputDateFormatter.date(from: now_dt) {
            let hour = Calendar.current.component(.hour, from: date)
            switch hour {
            case 0..<6:
                return "night"
            case 6..<10:
                return "morning"
            case 10..<18:
                return "day"
            case 18..<24:
                return "evening"
            default:
                return "today"
            }
        } else {
            print("Invalid date format: \(now_dt)")
            return "evening"
        }
    }
}
