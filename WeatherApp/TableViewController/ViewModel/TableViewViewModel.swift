//
//  TableViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

class TableViewViewModel: TableViewViewModelType {
    
    private let cities =
        [City(id: 235445,
              name: "Novosibirsk",
              temperature: -20,
              pressure: 111,
              humidity: 70,
              description: "Cold",
              coordinates: Coordinates(longitude: 1, latitude: 1)),
         City(id: 126875,
              name: "Moscow",
              temperature: -5,
              pressure: 222,
              humidity: 85,
              description: "Sunny",
              coordinates: Coordinates(longitude: 2, latitude: 2)),
         City(id: 98678,
              name: "Orel",
              temperature: 3,
              pressure: 754,
              humidity: 50,
              description: "Warm",
              coordinates: Coordinates(longitude: 3, latitude: 3))]
    
    var numberOfRows: Int {
        return cities.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> TableViewCellViewModelType? {
        let city = cities[indexPath.row]
        return TableViewCellViewModel(city: city)
    }
    
    func detailViewModel(for indexPath: IndexPath) -> DetailViewViewModelType? {
        let city = cities[indexPath.row]
        return DetailViewViewModel(city: city)
    }
    
    func selectLocationViewModel(for indexPath: IndexPath) -> SelectLocationViewViewModelType? {
        if indexPath.row >= numberOfRows {
            return SelectLocationViewViewModel(city: nil)
        } else {
            let city = cities[indexPath.row]
            return SelectLocationViewViewModel(city: city)
        }
    }
}
