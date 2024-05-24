//
//  NetworkManager.swift
//  WeatherYandexApp
//
//  Created by Владислав Соколов on 22.05.2024.
//

import Foundation
import Alamofire
import CoreLocation

final class NetworkManager {
    static let shared = NetworkManager()
    
    let headers: HTTPHeaders = [
        "X-Yandex-API-Key": "0196515a-68e3-499a-b46c-70059c23014f"
    ]
    
    private init() {}
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping(Result<Weather, AFError>) -> Void) {
        let baseURL = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)"
        AF.request(baseURL, headers: headers)
            .validate()
            .responseDecodable(of: WeatherData.self) { dataResponce in
                switch dataResponce.result {
                case .success(let weatherData):
                    let weather = Weather(weatherData: weatherData)
                    completion(.success(weather))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
    func fetchCoordinate(from city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> Void) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            completion(placemark?.first?.location?.coordinate, error)
        }
    }
    
    func fetchCityWeather(cities: [String], completion: @escaping (Int, Weather) -> Void) {
        for (index, item) in cities.enumerated() {
            fetchCoordinate(from: item) { coordinate, error in
                guard let coordinate, error == nil else { return }
                self.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { result in
                    switch result {
                    case .success(let weather):
                        completion(index, weather)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}
