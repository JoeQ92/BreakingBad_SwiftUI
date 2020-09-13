//
//  CharacterListViewController.swift
//  BreakingBad
//
//  Created by Joe Quesne on 13/09/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    var viewModel: CharacterListViewModel?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else {
            fatalError()
        }
        
        viewModel.delegate = self
        viewModel.loadCharacters()
    }
    
    @IBAction func seasonFilterValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel?.seasonFilter = [1, 2, 3, 4, 5]
        default:
            viewModel?.seasonFilter = [(sender.selectedSegmentIndex)]
        }
    }
    
}

// MARK: - ViewModel Delegate
extension CharacterListViewController: CharacterListViewModelDelegate {
    func charactersUpdated() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView Source
extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.charactersFiltered.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel?.charactersFiltered[indexPath.row].name
        return cell
    }
}

// MARK: - TableView Delegate
extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let character = viewModel?.charactersFiltered[indexPath.row] {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(identifier: "CharacterDetailsVC") as? CharacterDetailsViewController {
                detailVC.character = character
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}

// MARK: - SearchBar Delegate
extension CharacterListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.nameFilter = searchText
    }
}
