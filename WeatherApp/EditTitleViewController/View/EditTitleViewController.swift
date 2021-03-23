//
//  EditTitleViewController.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import UIKit

protocol TableViewDelegate: class {
    func viewModel(_ viewModel: EditTitleViewViewModelType, attemptsToEditName name: String)
}

class EditTitleViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var nameTextField: UITextField!
    
    var viewModel: EditTitleViewViewModelType!
    weak var delegate: TableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupViews()
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        guard let newName = nameTextField.text else { return }
        if newName.isEmpty {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            
        }
    }
}

// MARK: - Private
private extension EditTitleViewController {
    
    func setupViews() {
        nameTextField.placeholder = viewModel.name
    }
}
