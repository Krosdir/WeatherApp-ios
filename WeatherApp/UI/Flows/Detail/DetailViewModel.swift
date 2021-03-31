//
//  DetailViewViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol DetailViewModelActionDelegate: class {
    func viewModelAttemptsToEditCity(_ viewModel: DetailViewModelType)
}

class DetailViewModel: DetailViewModelType {
    
    private var city: City!
    weak var actionDelegate: DetailViewModelActionDelegate?
    
    var name: String {
        return city.name
    }
    
    var temperature: String {
        return String(describing: city.temperature)
    }
    
    var pressure: String {
        return String(describing: city.pressure)
    }
    
    var humidity: String {
        return String(describing: city.humidity)
    }
    
    var description: String {
        return city.description
    }
    
    init(city: City) {
        self.city = city
    }
    
    func selectLocationViewModel() -> SelectLocationViewModelType? {
        return SelectLocationViewModel(city: city)
    }
    
    // MARK: - ActionDelegate
    func attemptsToEditCity(with viewModel: DetailViewModelType) {
        viewModel.actionDelegate?.viewModelAttemptsToEditCity(viewModel)
    }
}
