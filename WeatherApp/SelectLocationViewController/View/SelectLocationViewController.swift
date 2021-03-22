//
//  SelectLocationViewController.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import UIKit

class SelectLocationViewController: UIViewController, Storyboarded {
    
    var viewModel: SelectLocationViewViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Actions
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let editTitleViewController = EditTitleViewController.instantiate()
        editTitleViewController.viewModel = viewModel.editTitleViewModel()
        
        self.navigationController?.pushViewController(editTitleViewController, animated: true)
    }
}
