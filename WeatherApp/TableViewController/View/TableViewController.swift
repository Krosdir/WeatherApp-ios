//
//  TableViewController.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var viewModel: TableViewViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TableViewViewModel()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < viewModel.numberOfRows {
            let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier,
                                                     for: indexPath) as! CityTableViewCell
            guard let cellViewModel = viewModel.cellViewModel(for: indexPath) else { return UITableViewCell() }
            cell.setName(cellViewModel.name)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddCityTableViewCell.identifier,
                                                     for: indexPath) as! AddCityTableViewCell
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < viewModel.numberOfRows,
              let detailViewModel = viewModel.detailViewModel(for: indexPath) else { return }
        
        let detailViewController = DetailViewController.instantiate()
        detailViewController.viewModel = detailViewModel
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
