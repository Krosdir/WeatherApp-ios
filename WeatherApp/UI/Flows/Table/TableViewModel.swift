//
//  TableViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol TableViewModelActionDelegate: class {
    func viewModel(_ viewModel: TableViewModelType, attemptsToOpenDetailAtIndexPath indexPath: IndexPath)
    func viewModel(_ viewModel: TableViewModelType, attemptsToEditCityAtIndexPath indexPath: IndexPath)
    func viewModelAttemptsToAddCity(_ viewModel: TableViewModelType)
}

protocol TableViewModelDisplayDelegate: class {
    func viewModelDidUpdated(_ viewModel: TableViewModelType)
}

class TableViewModel: TableViewModelType {
    
    private var cities = [City]()
    weak var actionDelegate: TableViewModelActionDelegate?
    weak var displayDelegate: TableViewModelDisplayDelegate?
    
    init() {
        if let cities = LocalStorageService.shared.loadCities() {
            self.cities = cities
            self.displayDelegate?.viewModelDidUpdated(self)
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
    
    func getCity(at indexPath: IndexPath) -> City? {
        return cities[indexPath.row]
    }
    
    func cellViewModel(for indexPath: IndexPath) -> CityTableViewCellViewModelType? {
        let city = cities[indexPath.row]
        return CityTableViewCellViewModel(city: city)
    }
    
    func detailViewModel(for indexPath: IndexPath) -> DetailViewModelType? {
        let city = cities[indexPath.row]
        return DetailViewModel(city: city)
    }
    
    func placeCity(_ city: City) {
        guard let index = cities.firstIndex(of: city) else {
            cities.append(city)
            saveCities()
            return
        }
        
        cities[index] = city
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
    
    // MARK: - ActionDelegate
    func attemptsToOpenDetails(with viewModel: TableViewModelType, atIndexPath indexPath: IndexPath) {
        viewModel.actionDelegate?.viewModel(viewModel, attemptsToOpenDetailAtIndexPath: indexPath)
    }
    
    func attemptsToEditCity(with viewModel: TableViewModelType, atIndexPath indexPath: IndexPath) {
        viewModel.actionDelegate?.viewModel(viewModel, attemptsToEditCityAtIndexPath: indexPath)
    }
    
    func attemptsToAddCity(with viewModel: TableViewModelType) {
        viewModel.actionDelegate?.viewModelAttemptsToAddCity(viewModel)
    }
}

// MARK: - Private
private extension TableViewModel {
    func saveCities() {
        LocalStorageService.shared.save(cities: self.cities)
        self.displayDelegate?.viewModelDidUpdated(self)
    }
}
