//
//  LocalStorageService.swift
//  WeatherApp
//
//  Created by Krosdir on 25.03.2021.
//

import Foundation

class LocalStorageService {
    
    static let shared = LocalStorageService()
    private let defaults = UserDefaults.standard
    
    private init() {}

    func save(cities: [City]) {
        do {
            let encoder = JSONEncoder()
            let encodedData: Data = try encoder.encode(cities)
            defaults.setValue(encodedData, forKey: Constants.LocalStorageKeys.cities)
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    func loadCities() -> [City]? {
        guard let data = defaults.data(forKey: Constants.LocalStorageKeys.cities) else { return nil }
        let decoder = JSONDecoder()
        let decodedData = try? decoder.decode([City].self, from: data)
        return decodedData
    }
}
