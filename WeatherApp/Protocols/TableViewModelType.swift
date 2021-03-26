//
//  TableViewViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol TableViewModelType {
    var numberOfRows: Int { get }
    var delegate: TableViewModelDisplayDelegate? { get set }
    func cellViewModel(for indexPath: IndexPath) -> CityTableViewCellViewModelType?
    func detailViewModel(for indexPath: IndexPath) -> DetailViewModelType?
    func selectLocationViewModel(for indexPath: IndexPath) -> SelectLocationViewModelType?
    func placeCity(city: City, with name: String)
    func updateCities()
}
