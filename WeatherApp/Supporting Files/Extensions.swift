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
    func transition(animations: @escaping () -> Void) {
        UIView.transition(with: self,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: animations,
                          completion: nil)
    }
    
    func hideView<T: UIView>(_ type: T.Type) {
        guard let view = subviews.first(where: { $0 is T }) else { return }
        transition { view.removeFromSuperview() }
    }
    
    func showView<T: UIView>(configure: ((T) -> Void)? = nil) -> T {
        let view = T(frame: bounds)
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        configure?(view)
        
        transition { self.addSubview(view) }
        
        return view
    }
    
    @discardableResult
    func showActivity() -> ActivityView {
        guard let loadingView = subviews.compactMap({ $0 as? ActivityView }).first else {
            return showView()
        }
        
        transition { self.bringSubviewToFront(loadingView) }
        return loadingView
    }
    
    func hideActivity() {
        hideView(ActivityView.self)
    }
}

// MARK: - UIViewController
extension UIViewController: Storyboarded { }
