//
//  TableViewViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol TableViewModelType {
    var numberOfRows: Int { get }
    var displayDelegate: TableViewModelDisplayDelegate? { get set }
    var actionDelegate: TableViewModelActionDelegate? { get set }
    
    func getCity(at indexPath: IndexPath) -> City?
    func cellViewModel(for indexPath: IndexPath) -> CityTableViewCellViewModelType?
    func detailViewModel(for indexPath: IndexPath) -> DetailViewModelType?
    func placeCity(_ city: City)
    func removeCity(at indexPath: IndexPath)
    func updateCities()
    
    func attemptsToOpenDetails(with viewModel: TableViewModelType, atIndexPath indexPath: IndexPath)
    func attemptsToEditCity(with viewModel: TableViewModelType, atIndexPath indexPath: IndexPath)
    func attemptsToAddCity(with viewModel: TableViewModelType)
}
