//
//  TableViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol TableViewModelDisplayDelegate: class {
    func reloadTable()
}

class TableViewModel: TableViewModelType {
    
    private var cities = [City]()
    weak var delegate: TableViewModelDisplayDelegate?
    
    init() {
        if let cities = LocalStorageService.shared.loadCities() {
            self.cities = cities
            self.delegate?.reloadTable()
        } else {
            CityNetworkService.getCities { (response) in
                self.cities += response.cities
                LocalStorageService.shared.save(cities: self.cities)
                self.delegate?.reloadTable()
            }
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
        LocalStorageService.shared.save(cities: self.cities)
        self.delegate?.reloadTable()
    }
    
    func updateCities() {
        guard let cities = LocalStorageService.shared.loadCities() else { return }
        self.cities = cities
    }
}
