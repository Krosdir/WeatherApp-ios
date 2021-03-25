//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Krosdir on 25.03.2021.
//

import CoreLocation
import MapKit
import UIKit

class MapViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!
    
    var viewModel: SelectLocationViewModelType!
    private var locationManager: CLLocationManager!
    private var currentLocationStr = "Current location"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func addCityButtonAction(_ sender: Any) {
    }
}
