//
//  GameListViewController.swift
//  FinalProject
//
//  Created by Tarik Efe on 6.12.2022.
//

import UIKit

final class GameListViewController: UIViewController {
//MARK: Outlets
    @IBOutlet private weak var gameListTableView: UITableView! {
        didSet {
            gameListTableView.dataSource = self
            gameListTableView.delegate = self
            gameListTableView.register(UINib(nibName: "GameListTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        }
    }
    
//MARK: Variables
    private var viewModel: GameListViewModelProtocol = GameListViewModel()
    private var searchBar = UISearchBar()
    private var searchController = UISearchController(searchResultsController: nil)
    
//MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchGamesList()
        defaultSearchController()
    }
}

//MARK: Methods


//MARK: Extensions
extension GameListViewController: GameListViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
    }
}

extension GameListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getGamesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as? GameListTableViewCell, let model = viewModel.getGames(at: indexPath.row) else { return UITableViewCell() }
        cell.configureCell(game: model)
        return cell
    }
}

extension GameListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension GameListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (gameListTableView.contentSize.height-100-scrollView.frame.size.height) {
            viewModel.nextFetchGamesList()
            self.gameListTableView.reloadData()
        }
    }
}

extension GameListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.searchFetchGamesList(textSearch: searchText)
        self.gameListTableView.reloadData()
    }
    
    func defaultSearchController() {
        navigationItem.searchController = searchController
        searchBar = searchController.searchBar
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
    }
}
