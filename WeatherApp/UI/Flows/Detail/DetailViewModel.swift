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
    
    init(city: City) {
        self.city = city
    }
    
    func getCity() -> City {
        return city
    }
    
    func attemptsToUpdateCity(with city: City, andEditName name: String, completion: () -> Void) {
//        LocalStorageService.shared.save(cities: self.cities)
//        completion()
    }
    
    // MARK: - ActionDelegate
    func attemptsToEditCity(with viewModel: DetailViewModelType) {
        viewModel.actionDelegate?.viewModelAttemptsToEditCity(viewModel)
    }
}
