//
//  Extensions.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import Foundation
import UIKit

// MARK: - UITableViewCell
extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
