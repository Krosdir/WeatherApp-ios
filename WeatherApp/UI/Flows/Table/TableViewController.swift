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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.numberOfRows == 0 { view.showActivity() }
        reloadTable()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < viewModel.numberOfRows {
            let cell = tableView.dequeueCell(for: indexPath, with: CityTableViewCell.self)
            guard let cellViewModel = viewModel.cellViewModel(for: indexPath) else { return UITableViewCell() }
            
            cell.viewModel = cellViewModel
            cell.editButtonTapped = { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.viewModel.attemptsToEditCity(with: weakSelf.viewModel, atIndexPath: indexPath)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueCell(for: indexPath, with: AddCityTableViewCell.self)
            
            return cell
        }
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < viewModel.numberOfRows {
            viewModel.attemptsToOpenDetails(with: viewModel, atIndexPath: indexPath)
        } else {
            viewModel.attemptsToAddCity(with: viewModel)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != .delete { return }
        
        viewModel.removeCity(at: indexPath)
    }
}

// MARK: - TableViewModelDisplayDelegate
extension TableViewController: TableViewModelDisplayDelegate {
    func viewModelDidUpdated(_ viewModel: TableViewModelType) {
        reloadTable()
        DispatchQueue.main.async {
            self.view.hideActivity()
        }
    }
}

// MARK: - Private
private extension TableViewController {
    func reloadTable() {
        viewModel.updateCities()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
