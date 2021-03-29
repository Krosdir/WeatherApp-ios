//
//  MapViewModelType.swift
//  WeatherApp
//
//  Created by Krosdir on 25.03.2021.
//

import Foundation
import MapKit

protocol MapViewModelType {
    var cityCoordinates: [Coordinates] { get }
    var displayDelegate: MapViewModelDisplayDelegate? { get set }
    var center: Coordinates { get }
    var mapScale: Double { get }
    func detailViewModel(for annotation: MKAnnotation) -> DetailViewModelType?
    func selectLocationViewModel() -> SelectLocationViewModelType?
    func placeCity(city: City, with name: String)
    func updateCities()
}
