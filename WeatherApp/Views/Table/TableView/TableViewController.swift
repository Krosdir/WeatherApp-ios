//
//  TableViewController.swift
//  WeatherApp
//
//  Created by Krosdir on 22.03.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var viewModel: TableViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TableViewModel()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadTable()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < viewModel.numberOfRows {
            let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier,
                                                     for: indexPath) as! CityTableViewCell
            guard let cellViewModel = viewModel.cellViewModel(for: indexPath),
                  let locationViewModel = viewModel.selectLocationViewModel(for: indexPath) else {
                return UITableViewCell()
            }
            cell.viewModel = cellViewModel
            cell.editButtonTapped = { [weak self] in
                self?.openSelectLocationController(with: locationViewModel)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddCityTableViewCell.identifier,
                                                     for: indexPath) as! AddCityTableViewCell
            
            return cell
        }
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < viewModel.numberOfRows {
            guard let detailViewModel = viewModel.detailViewModel(for: indexPath) else { return }
            
            let detailViewController = DetailViewController.instantiate()
            detailViewController.viewModel = detailViewModel
            
            self.navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            guard let selectLocationViewModel = viewModel.selectLocationViewModel(for: indexPath) else { return }
            
            openSelectLocationController(with: selectLocationViewModel)
        }
        
    }
}

// MARK: - TableViewDelegate
extension TableViewController: TableViewDelegate {
    func viewModel(_ city: City, attemptsToEditName name: String) {
        self.viewModel.placeCity(city: city, with: name)
    }
    
}

// MARK: - TableViewModelDisplayDelegate
extension TableViewController: TableViewModelDisplayDelegate {
    func tableViewModelDidUpdate(_ viewModel: TableViewModelType) {
        reloadTable()
    }
}

// MARK: - Private
private extension TableViewController {
    func openSelectLocationController(with viewModel: SelectLocationViewModelType?) {
        let selectLocationViewController = SelectLocationViewController.instantiate()
        selectLocationViewController.viewModel = viewModel
        
        self.navigationController?.pushViewController(selectLocationViewController, animated: true)
    }
    
    func reloadTable() {
        viewModel.updateCities()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
