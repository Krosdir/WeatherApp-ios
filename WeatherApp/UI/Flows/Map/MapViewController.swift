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
        viewModel.displayDelegate = self
        mapView.delegate = self
        setupLocationManager()
        placeAnnotations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadMap()
        determineLocation()
    }
    
    // MARK: - Actions
    
    @IBAction func addCityButtonAction(_ sender: Any) {
        let selectLocationViewModel = viewModel.selectLocationViewModel()
        let selectLocationViewController = SelectLocationViewController.instantiate()
        selectLocationViewController.viewModel = selectLocationViewModel

        self.navigationController?.pushViewController(selectLocationViewController, animated: true)
    }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        let detailViewModel = viewModel.detailViewModel(for: annotation)
        let detailViewController = DetailViewController.instantiate()
        detailViewController.viewModel = detailViewModel
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
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
    func viewModelDidUpdate(_ viewModel: MapViewModelType) {
        reloadMap()
    }

}

// MARK: - Private
private extension MapViewController {
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func determineLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func placeAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
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
    
    func reloadMap() {
        viewModel.updateCities()
        placeAnnotations()
    }
}
