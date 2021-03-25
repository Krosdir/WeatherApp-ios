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
    
    var viewModel: MapViewModelType!
    private var locationManager: CLLocationManager!
    private var currentLocationStr = "Current location"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MapViewModel()
        viewModel.delegate = self
        setupLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadMap()
        determineCurrentLocation()
    }
    
    // MARK: - Actions
    
    @IBAction func addCityButtonAction(_ sender: Any) {
        let selectLocationViewModel = viewModel.selectLocationViewModel()
        let selectLocationViewController = SelectLocationViewController.instantiate()
        selectLocationViewController.viewModel = selectLocationViewModel

        self.navigationController?.pushViewController(selectLocationViewController, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let scale = viewModel.mapScale
        let center = CLLocationCoordinate2D(latitude: viewModel.center.latitude, longitude: viewModel.center.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: scale, longitudeDelta: scale))
        mapView.setRegion(mRegion, animated: false)
        
        viewModel.cityCoordinates.forEach { (coordinates) in
            let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
            mkAnnotation.coordinate = CLLocationCoordinate2DMake(coordinates.latitude, coordinates.longitude)
            mapView.addAnnotation(mkAnnotation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
    
    //MARK:- Intance Methods

    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }

    func determineCurrentLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - TableViewDelegate
extension MapViewController: TableViewDelegate {
    func viewModel(_ city: City, attemptsToEditName name: String) {
        self.viewModel.placeCity(city: city, with: name)
    }
    
}

// MARK: - MapViewModelDisplayDelegate
extension MapViewController: MapViewModelDisplayDelegate {
    func reloadMap() {
        viewModel.updateCities()
        // bad map updating
        locationManager(locationManager, didUpdateLocations: [CLLocation(latitude: 0, longitude: 0)])
    }
}
