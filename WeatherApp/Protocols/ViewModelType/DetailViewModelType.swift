//
//  DetailViewViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol DetailViewModelType {
    var actionDelegate: DetailViewModelActionDelegate? { get set }
    
    func getCity() -> City
    func attemptsToEditCity(with viewModel: DetailViewModelType)
}
