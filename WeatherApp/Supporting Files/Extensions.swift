//
//  Extensions.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import CoreLocation
import Foundation
import UIKit

// MARK: - Notification.Name
extension Notification.Name {
    static let reloadTable = Notification.Name("reloadTable")
}

// MARK: - CLLocation
extension CLLocation {
    func fetchCity(completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $1) }
    }
}

// MARK: - UITableViewCell
extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
