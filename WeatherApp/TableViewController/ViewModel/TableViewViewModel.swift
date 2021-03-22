//
//  TableViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

class TableViewViewModel: TableViewViewModelType {
    
    private let cities = [City(name: "Novosibirsk", temperature: -20, pressure: 111, humidity: 70, description: "Cold"),
                  City(name: "Moscow", temperature: -5, pressure: 222, humidity: 85, description: "Sunny"),
                  City(name: "Orel", temperature: 3, pressure: 754, humidity: 50, description: "Warm")]
    
    var numberOfRows: Int {
        return cities.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> TableViewCellViewModelType? {
        let city = cities[indexPath.row]
        return TableViewCellViewModel(city: city)
    }
}
