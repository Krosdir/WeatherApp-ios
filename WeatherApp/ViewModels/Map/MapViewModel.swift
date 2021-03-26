//
//  MapViewModel.swift
//  WeatherApp
//
//  Created by Krosdir on 25.03.2021.
//

import Foundation

protocol MapViewModelDisplayDelegate: class {
    func mapViewModelDidUpdate(_ viewModel: MapViewModelType)
}

class MapViewModel: MapViewModelType {
    
    private var cities = [City]()
    weak var delegate: MapViewModelDisplayDelegate?
    
    var cityNames: [String] {
        return cities.map { $0.name }
    }
    
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
    
    func selectLocationViewModel() -> SelectLocationViewModelType? {
        return SelectLocationViewModel(city: nil)
    }
    
    func placeCity(city: City, with name: String) {
        if cities.contains(city) {
            guard let index = cities.firstIndex(of: city) else { return }
            cities[index].name = name
        } else {
            cities.append(city)
        }
        LocalStorageService.shared.save(cities: self.cities)
        self.delegate?.mapViewModelDidUpdate(self)
    }
    
    func updateCities() {
        guard let cities = LocalStorageService.shared.loadCities() else { return }
        self.cities = cities
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
        
        mapScale = ceil(max)
    }
}
