//
//  TableViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol TableViewModelDisplayDelegate: class {
    func tableViewModelDidUpdated(_ viewModel: TableViewModelType)
}

class TableViewModel: TableViewModelType {
    
    private var cities = [City]()
    weak var displayDelegate: TableViewModelDisplayDelegate?
    
    init() {
        if let cities = LocalStorageService.shared.loadCities() {
            self.cities = cities
            self.displayDelegate?.tableViewModelDidUpdated(self)
        } else {
            do {
                try CityNetworkService.shared.getCities { (response) in
                    self.cities = response
                    self.saveCities()
                }
                
            } catch CityNetworkError.badURL {
                print("ERROR: Can't build a correct URL")
                
            } catch CityNetworkError.imposibleParsing {
                print("ERROR: Can't parse City model")
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    var numberOfRows: Int {
        return cities.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> CityTableViewCellViewModelType? {
        let city = cities[indexPath.row]
        return CityTableViewCellViewModel(city: city)
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
    
    func placeCity(_ city: City, with name: String) {
        guard let index = cities.firstIndex(of: city) else {
            var namedCity = city
            namedCity.name = name
            cities.append(namedCity)
            saveCities()
            return
        }
        
        cities[index].name = name
        saveCities()
    }
    
    func removeCity(at indexPath: IndexPath) {
        guard indexPath.row < numberOfRows else {
            print("ERROR: City with indexPath = \(indexPath) isn't found")
            return
        }
        
        cities.remove(at: indexPath.row)
        saveCities()
    }
    
    func updateCities() {
        guard let cities = LocalStorageService.shared.loadCities() else { return }
        self.cities = cities
    }
}

// MARK: - Private
private extension TableViewModel {
    func saveCities() {
        LocalStorageService.shared.save(cities: self.cities)
        self.displayDelegate?.tableViewModelDidUpdated(self)
    }
}
