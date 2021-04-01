//
//  Extensions.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import CoreLocation
import Foundation
import UIKit

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

// MARK: - UIView
extension UIView {
    func showSpinner() {
        let spinnerView = UIView(frame: self.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        spinnerView.tag = 100
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = .white
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.addSubview(spinnerView)
        }
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            let view = self.subviews.first(where: { $0.tag == 100 })
            view?.removeFromSuperview()
        }
    }
}

// MARK: - UIViewController
extension UIViewController: Storyboarded { }
