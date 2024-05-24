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
    
    
    // MARK: - Other methods
    @IBAction func addNewTown(_ sender: UIBarButtonItem) {
        alertController(with: "Город", and: "Укажи название") { [unowned self] town in
            dataStore.nameCities.append(town)
            weathers.append(emptyCitie)
            addSities()
        }
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
    
    private func alertController(with title: String, and message: String, completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in 
            let textField = alert.textFields?.first
            guard let inputText = textField?.text, !inputText.isEmpty else { return }
            completion(inputText)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField { textField in
            textField.placeholder = "Введите название города"
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


