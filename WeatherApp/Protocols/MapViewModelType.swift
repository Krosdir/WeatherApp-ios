//
//  MapViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 25.03.2021.
//

import Foundation

protocol MapViewModelType {
    var cityNames: [String] { get }
    var cityCoordinates: [Coordinates] { get }
    var delegate: MapViewModelDisplayDelegate? { get set }
    var center: Coordinates { get }
    var mapScale: Double { get }
    func selectLocationViewModel() -> SelectLocationViewModelType?
    func placeCity(city: City, with name: String)
    func updateCities()
}
