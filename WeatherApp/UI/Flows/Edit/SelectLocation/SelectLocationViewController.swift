//
//  SelectLocationViewController.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import CoreLocation
import MapKit
import UIKit

class SelectLocationViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    
    var viewModel: SelectLocationViewModelType!
    private var locationManager: CLLocationManager!
    private var currentLocationStr = "Current location"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.displayDelegate = self
        setupLocationManager()
        setupMap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        determineLocation()
    }
    // MARK: - Actions
    @IBAction func nextButtonAction(_ sender: Any) {
        self.view.showActivity()
        self.fetchCity()
    }
}

// MARK: - SelectLocationViewModelDisplayDelegate
extension SelectLocationViewController: SelectLocationViewModelDisplayDelegate {
    func viewModelDidUpdated(_ viewModel: SelectLocationViewModelType) {
        DispatchQueue.main.async {
            viewModel.attemptsToAContinueEditing(with: viewModel)
            self.view.hideActivity()
        }
    }
    
}

// MARK: - Private
private extension SelectLocationViewController {

    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)
        
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            
            if let mPlacemark = placemarks {
                if let dict = mPlacemark[0].addressDictionary as? [String: Any] {
                    if let _ = dict["Name"] as? String {
                        if let city = dict["City"] as? String {
                            self.currentLocationStr = city
                        }
                    }
                }
            }
        }
        return currentLocationStr
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func setupMap() {
        var mUserLocation: CLLocation
        mUserLocation = CLLocation(latitude: viewModel.coordinates.latitude, longitude: viewModel.coordinates.longitude)
        
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(mRegion, animated: false)
        
        // Get user's Current Location and Drop a pin
        let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
        mkAnnotation.coordinate = CLLocationCoordinate2DMake(mUserLocation.coordinate.latitude, mUserLocation.coordinate.longitude)
        mkAnnotation.title = self.setUsersClosestLocation(mLattitude: mUserLocation.coordinate.latitude, mLongitude: mUserLocation.coordinate.longitude)
        mapView.addAnnotation(mkAnnotation)
    }

    func determineLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func fetchCity() {
        var mUserLocation: CLLocation
        let mapCoordinates = Coordinates(longitude: mapView.centerCoordinate.longitude, latitude: mapView.centerCoordinate.latitude)
        if viewModel.coordinates == mapCoordinates {
            mUserLocation = CLLocation(latitude: viewModel.coordinates.latitude, longitude: viewModel.coordinates.longitude)
            viewModel.fetchCity(coordinates: Coordinates(longitude: mUserLocation.coordinate.longitude, latitude: mUserLocation.coordinate.latitude))
        } else {
            mUserLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
            viewModel.fetchCity(coordinates: Coordinates(longitude: mUserLocation.coordinate.longitude, latitude: mUserLocation.coordinate.latitude))
        }
    }
}
