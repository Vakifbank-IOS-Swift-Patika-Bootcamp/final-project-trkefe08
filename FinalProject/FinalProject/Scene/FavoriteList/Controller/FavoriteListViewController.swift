//
//  FavoriteListViewController.swift
//  FinalProject
//
//  Created by Tarik Efe on 13.12.2022.
//

import UIKit

class FavoriteListViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet private weak var favoriteTableView: UITableView! {
        didSet {
            favoriteTableView.delegate = self
            favoriteTableView.dataSource = self
            favoriteTableView.register(UINib(nibName: "GameListTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        }
    }
    
    //MARK: Variables
    private var viewModel: FavoriteListViewModelProtocol = FavoriteListViewModel()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchGamesFromCoreData()
    }
}

//MARK: Extensions
extension FavoriteListViewController: FavoriteListViewModelDelegate {
    func favoritesLoaded() {
        favoriteTableView.reloadData()
    }
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getFavoriteGameCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as? GameListTableViewCell, let model = viewModel.getFavorite(at: indexPath.row) else { return UITableViewCell() }
        cell.configureFavoriteGameCell(favorites: model)
        return cell
    }
    
    
}
