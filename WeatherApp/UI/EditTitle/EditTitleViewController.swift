//
//  EditTitleViewController.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import UIKit

protocol TableViewDelegate: class {
    func viewModel(_ city: City, attemptsToEditName name: String)
}

class EditTitleViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    
    var viewModel: EditTitleCityViewModelType!
    weak var delegate: TableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableViewController = self.navigationController?.viewControllers.first as! TableViewDelegate
        delegate = tableViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupViews()
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        guard let newName = nameTextField.text,
              let city = viewModel.city else { return }
        if newName.isEmpty {
            delegate?.viewModel(city, attemptsToEditName: viewModel.name)
        } else {
            delegate?.viewModel(city, attemptsToEditName: newName)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Private
private extension EditTitleViewController {
    
    func setupViews() {
        nameTextField.placeholder = viewModel.name
        nameTextField.text = viewModel.name
    }
}
