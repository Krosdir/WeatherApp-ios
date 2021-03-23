//
//  TableViewViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation

protocol TableViewViewModelType {
    var numberOfRows: Int { get }
    func cellViewModel(for indexPath: IndexPath) -> TableViewCellViewModelType?
    func detailViewModel(for indexPath: IndexPath) -> DetailViewViewModelType?
    func selectLocationViewModel(for indexPath: IndexPath) -> SelectLocationViewViewModelType?
}
