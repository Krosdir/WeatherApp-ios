//
//  TableViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

class TableViewViewModel: TableViewViewModelType {
    
    private var cities = [City]()
    
    init() {
        CityNetworkService.getCities { (response) in
            self.cities += response.cities
            NotificationCenter.default.post(name: .reloadTable, object: nil)
        }
    }
    
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
