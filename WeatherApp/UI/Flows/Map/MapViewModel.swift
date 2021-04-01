//
//  MapViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 25.03.2021.
//

import Foundation
import MapKit

protocol MapViewModelActionDelegate: class {
    func viewModelAttemptsToAddCity(_ viewModel: MapViewModelType)
    func viewModel(_ viewModel: MapViewModelType, attemptsToOpenDetailForAnnotation annotation: MKAnnotation)
}

protocol MapViewModelDisplayDelegate: class {
    func viewModelDidUpdate(_ viewModel: MapViewModelType)
}

class MapViewModel: MapViewModelType {
    
    private var cities = [City]()
    weak var actionDelegate: MapViewModelActionDelegate?
    weak var displayDelegate: MapViewModelDisplayDelegate?
    
    var cityCoordinates: [Coordinates] {
        return cities.map { $0.coordinates }
    }
    
    var center: Coordinates {
        guard let center = getCenter() else { return Coordinates(longitude: 0, latitude: 0)}
        return center
    }
    
    var mapScale = Double()
    
    init() {
        guard let cities = LocalStorageService.shared.loadCities() else { return }
        self.cities = cities
    }
    
    func getCity(forAnnotation annotation: MKAnnotation) -> City? {
        let coordinates = getCoordinates(for: annotation)
        guard let city = cities.first(where: { $0.coordinates == coordinates }) else { return nil }
        return city
    }
    
    func detailViewModel(for annotation: MKAnnotation) -> DetailViewModelType? {
        let coordinates = getCoordinates(for: annotation)
        guard let city = cities.first(where: { $0.coordinates == coordinates }) else { return nil }
        return DetailViewModel(city: city)
    }
    
    func placeCity(_ city: City) {
        if cities.contains(city) {
            guard let index = cities.firstIndex(of: city) else { return }
            cities[index] = city
        } else {
            cities.append(city)
        }
        LocalStorageService.shared.save(cities: self.cities)
        self.displayDelegate?.viewModelDidUpdate(self)
    }
    
    func updateCities() {
        guard let cities = LocalStorageService.shared.loadCities() else { return }
        self.cities = cities
    }
    
    // MARK: - ActionDelegate
    func attemptsToAddCity(with viewModel: MapViewModelType) {
        viewModel.actionDelegate?.viewModelAttemptsToAddCity(viewModel)
    }
    
    func attemptsToOpenDetails(with viewModel: MapViewModelType, forAnnotation annotation: MKAnnotation) {
        viewModel.actionDelegate?.viewModel(viewModel, attemptsToOpenDetailForAnnotation: annotation)
    }
    
}

// MARK: - Private
private extension MapViewModel {
    // Get center relatively of all coordinates
    func getCenter() -> Coordinates? {
        let latitudeArray = cityCoordinates.map { $0.latitude }
        guard let minLatitude = latitudeArray.min(),
              let maxLatitude = latitudeArray.max() else { return nil }

        let longitudeArray = cityCoordinates.map { $0.longitude }
        guard let minLongitude = longitudeArray.min(),
              let maxLongitude = longitudeArray.max() else { return nil }
        
        setMapScale(latitude: maxLatitude - minLatitude, longitude: maxLongitude - minLongitude)
        
        let latutudeCenter = (minLatitude + maxLatitude) / 2
        let longitudeCenter = (minLongitude + maxLongitude) / 2
        
        return Coordinates(longitude: longitudeCenter, latitude: latutudeCenter)
    }
    
    func setMapScale(latitude: Double, longitude: Double) {
        guard let max = [latitude, longitude].max() else { return }
        
        if max.isZero {
            mapScale = 0.1
            return
        }
        
        if max > Constants.maxMKCoordinateSpan {
            mapScale = Constants.maxMKCoordinateSpan
            return
        }
        
        mapScale = ceil(max)
    }
    
    func getCoordinates(for annotation: MKAnnotation) -> Coordinates {
        let longtitude = annotation.coordinate.longitude
        let latitude = annotation.coordinate.latitude
        let coordinates = Coordinates(longitude: longtitude, latitude: latitude)
        return coordinates
    }
}
