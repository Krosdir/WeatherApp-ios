//
//  EditTitleViewController.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import UIKit

class EditTitleViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    
    var viewModel: EditTitleCityViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupViews()
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        guard let newName = nameTextField.text,
              var city = viewModel.city else {
            print("ERROR: EditTitleCityViewModelType doesn't retain a city")
            return
        }
        city.name = newName
        viewModel.attemptsToUpdateCity(city)
    }
}

// MARK: - Private
private extension EditTitleViewController {
    
    func setupViews() {
        nameTextField.placeholder = viewModel.name
        nameTextField.text = viewModel.name
    }
}
