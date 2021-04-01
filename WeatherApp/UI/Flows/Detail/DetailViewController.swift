//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var viewModel: DetailViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupViews()
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        viewModel.attemptsToEditCity(with: viewModel)
    }
    
}

// MARK: - Private
private extension DetailViewController {
    
    func setupViews() {
        let city = viewModel.getCity()
        
        self.navigationItem.title = city.name
        
        temperatureLabel.text = "Temperature: \(city.temperature)"
        pressureLabel.text = "Pressure: \(city.pressure)"
        humidityLabel.text = "Humidity: \(city.humidity)"
        descriptionLabel.text = "Description: \(city.description)"
    }
}
