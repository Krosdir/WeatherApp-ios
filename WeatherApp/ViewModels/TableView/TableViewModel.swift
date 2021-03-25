//
//  TableViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

class TableViewModel: TableViewModelType {
    
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
    
    func detailViewModel(for indexPath: IndexPath) -> DetailViewModelType? {
        let city = cities[indexPath.row]
        return DetailViewModel(city: city)
    }
    
    func selectLocationViewModel(for indexPath: IndexPath) -> SelectLocationViewModelType? {
        if indexPath.row >= numberOfRows {
            return SelectLocationViewModel(city: nil)
        } else {
            let city = cities[indexPath.row]
            return SelectLocationViewModel(city: city)
        }
    }
    
    func placeCity(city: City, with name: String) {
        if cities.contains(city) {
            guard let index = cities.firstIndex(of: city) else { return }
            cities[index].name = name
        } else {
            cities.append(city)
        }
        NotificationCenter.default.post(name: .reloadTable, object: nil)
    }
}
