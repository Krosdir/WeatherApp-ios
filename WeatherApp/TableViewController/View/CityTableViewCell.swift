//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UIButton!
    
    var detailViewModel: DetailViewViewModelType!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setName(_ name: String) {
        nameLabel.setTitle(name, for: .normal)
    }
    
    // MARK: - Action
    @IBAction func cityButtonAction(_ sender: Any) {
    }
    
    
}
