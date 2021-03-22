//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var viewModel: DetailViewViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupViews()
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        let selectLocationViewController = SelectLocationViewController.instantiate()
        selectLocationViewController.viewModel = viewModel.selectLocationViewModel()
        
        self.navigationController?.pushViewController(selectLocationViewController, animated: true)
    }
    
}

// MARK: - Private
private extension DetailViewController {
    
    func setupViews() {
        self.navigationItem.title = viewModel.name
        
        temperatureLabel.text = viewModel.temperature
        pressureLabel.text = viewModel.pressure
        humidityLabel.text = viewModel.humidity
        descriptionLabel.text = viewModel.description
    }
}
