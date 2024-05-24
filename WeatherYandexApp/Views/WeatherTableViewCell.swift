//
//  WeatherTableViewCell.swift
//  WeatherYandexApp
//
//  Created by Владислав Соколов on 23.05.2024.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    @IBOutlet var townNameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    func configure(weather: Weather) {
        townNameLabel.text = weather.name
        statusLabel.text = weather.conditionString
        temperatureLabel.text = weather.temperature.formatted()
    }
}
