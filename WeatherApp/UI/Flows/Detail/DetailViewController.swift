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
        self.navigationItem.title = viewModel.name
        
        temperatureLabel.text = "Temperature: \(viewModel.temperature)"
        pressureLabel.text = "Pressure: \(viewModel.pressure)"
        humidityLabel.text = "Humidity: \(viewModel.humidity)"
        descriptionLabel.text = "Description: \(viewModel.description)"
    }
}
