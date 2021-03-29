////  NetworkManager.swift
//  WeatherApp
//
//  Created by Krosdir on 23.03.2021.
//

import Foundation

class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    func getData(url: URL, completion: @escaping (Any) throws -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("ERROR: No request data has gotten")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                try completion(json)
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }.resume()
    }
}
