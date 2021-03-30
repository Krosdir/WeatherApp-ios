//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UIButton!
    
    var editButtonTapped: (() -> Void)?
    
    var viewModel: CityTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            nameLabel.setTitle(viewModel.name, for: .normal)
        }
    }
    
    // MARK: - Action
    
    @IBAction func editButtonAction(_ sender: Any) {
        self.editButtonTapped?()
    }
    
}
