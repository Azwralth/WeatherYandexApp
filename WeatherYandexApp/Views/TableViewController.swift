//
//  ViewController.swift
//  WeatherYandexApp
//
//  Created by Владислав Соколов on 22.05.2024.
//

import UIKit

final class TableViewController: UITableViewController {
    
    let emptyCitie = Weather()
    let dataStore = DataStore.shared
    var weathers: [Weather] = []
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if weathers.isEmpty {
            weathers = Array(repeating: emptyCitie, count: dataStore.nameCities.count)
        }
        addSities()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let weather = weathers[indexPath.row]
        if let detailWeatherVC = segue.destination as? DetailViewController {
            detailWeatherVC.weather = weather
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weathers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weather", for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        let weather = weathers[indexPath.row]
        cell.configure(weather: weather)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        weathers.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func addNewTown(_ sender: UIBarButtonItem) {
    }
    
    
    func addSities() {
        networkManager.fetchCityWeather(cities: dataStore.nameCities) { [unowned self] index, weather in
            weathers[index] = weather
            weathers[index].name = self.dataStore.nameCities[index]
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(weather)
            }
        }
    }
}


