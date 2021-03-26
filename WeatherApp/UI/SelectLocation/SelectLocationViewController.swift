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
        
        setupLocationManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        determineCurrentLocation()
    }
    // MARK: - Actions
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let editTitleViewController = EditTitleViewController.instantiate()
        editTitleViewController.viewModel = viewModel.editTitleViewModel()
        
        self.navigationController?.pushViewController(editTitleViewController, animated: true)
    }
}

// MARK: - MKMapViewDelegate, CLLocationManagerDelegate
extension SelectLocationViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var mUserLocation: CLLocation
        if viewModel.coordinates != Coordinates.zero {
            mUserLocation = CLLocation(latitude: viewModel.coordinates.latitude, longitude: viewModel.coordinates.longitude)
            viewModel.fetchCity(coordinates: Coordinates(longitude: mUserLocation.coordinate.longitude, latitude: mUserLocation.coordinate.latitude))
        } else {
            mUserLocation = locations[0] as CLLocation
            viewModel.fetchCity(coordinates: Coordinates(longitude: mUserLocation.coordinate.longitude, latitude: mUserLocation.coordinate.latitude))
        }
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(mRegion, animated: false)
        
        // Get user's Current Location and Drop a pin
        let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
        mkAnnotation.coordinate = CLLocationCoordinate2DMake(mUserLocation.coordinate.latitude, mUserLocation.coordinate.longitude)
        mkAnnotation.title = self.setUsersClosestLocation(mLattitude: mUserLocation.coordinate.latitude, mLongitude: mUserLocation.coordinate.longitude)
        mapView.addAnnotation(mkAnnotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
    
    //MARK:- Intance Methods
    
    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)
        
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            
            if let mPlacemark = placemarks {
                if let dict = mPlacemark[0].addressDictionary as? [String: Any] {
                    if let Name = dict["Name"] as? String {
                        if let City = dict["City"] as? String {
                            self.currentLocationStr = Name + ", " + City
                        }
                    }
                }
            }
        }
        return currentLocationStr
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
