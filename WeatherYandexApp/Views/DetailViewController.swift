//
//  DetailViewController.swift
//  WeatherYandexApp
//
//  Created by Владислав Соколов on 23.05.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet var nameTownLabel: UILabel!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var pressureMmLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var conditionImage: UIView!
    @IBOutlet var dateTodayLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windDirLabel: UILabel!
    
    var weather: Weather!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setupBackgroundImage()
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupLabels() {
        dateTodayLabel.text = "Сегодня \(weather.formattedDate())"
        dateTodayLabel.textColor = .white
        
        nameTownLabel.text = weather.name
        nameTownLabel.textColor = .white
        
        conditionLabel.text = weather.conditionString
        conditionLabel.textColor = .white
        
        humidityLabel.text = weather.humidity.formatted()
        humidityLabel.textColor = .white
        
        temperatureLabel.text = weather.temperature.formatted()
        temperatureLabel.textColor = .white
        
        pressureMmLabel.text = weather.pressureMm.formatted()
        pressureMmLabel.textColor = .white
        
        windSpeedLabel.text = weather.windSpeed.formatted()
        windSpeedLabel.textColor = .white
        
        windDirLabel.text = weather.windDirectionString
        windDirLabel.textColor = .white
    }
    
    private func setupBackgroundImage() {
        let timeOfDay = weather.timeOfDay()
        let imageName: String
        
        switch timeOfDay {
        case "night":
            imageName = "6"
        case "morning":
            imageName = "5"
        case "day":
            imageName = "2"
        case "evening":
            imageName = "3"
        default:
            imageName = "1"
        }
        
        let backgroundImage = UIImage(named: imageName)
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.insertSubview(backgroundImageView, at: 0)
    }
}
