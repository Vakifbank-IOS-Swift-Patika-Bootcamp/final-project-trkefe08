//
//  GameListViewController.swift
//  FinalProject
//
//  Created by Tarik Efe on 6.12.2022.
//

import UIKit

final class GameListViewController: BaseViewController {
    //MARK: Outlets
    @IBOutlet private weak var gameListTableView: UITableView! {
        didSet {
            gameListTableView.dataSource = self
            gameListTableView.delegate = self
            gameListTableView.register(UINib(nibName: "GameListTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        }
    }
    
    @IBOutlet private weak var gamePopUpButton: UIButton!
    
    //MARK: - Variables
    private var viewModel: GameListViewModelProtocol = GameListViewModel()
    private var searchBar = UISearchBar()
    private var searchController = UISearchController(searchResultsController: nil)
    private var cellSpacingHeight: CGFloat = 1
    private var one: Int = 1
    private var indexPath: IndexPath = IndexPath(row:0, section:0)
    private var viewNotification: LocalNotificationProtocol = LocalNotificationManager()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchGamesList()
        indicator.startAnimating()
        defaultSearchController()
        setPopUpButton()
        title = "Games".localized()
        tabBarItem.title = "Games".localized()
        viewNotification.requestNotificationAuthorization()
        viewNotification.sendNotification()
    }
    //MARK: - Methods
    func setPopUpButton() {
        let optionClosure = {(action : UIAction) in
            if action.title == "Popular".localized() {
                self.viewModel.getPopularGames()
                self.gameListTableView.reloadData()
                self.gameListTableView.scrollToRow(at: self.indexPath, at: UITableView.ScrollPosition.top, animated: true)
            } else if action.title == "Games".localized() {
                self.viewModel.fetchGamesList()
                self.gameListTableView.reloadData()
                self.gameListTableView.scrollToRow(at: self.indexPath, at: UITableView.ScrollPosition.top, animated: true)
            }
        }
        gamePopUpButton.menu = UIMenu(children: [
            UIAction(title: "Games".localized(), state: .on, handler: optionClosure),
            UIAction(title: "Popular".localized(), handler: optionClosure)
        ])
    }
}

//MARK: - Extensions
extension GameListViewController: GameListViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
        indicator.stopAnimating()
    }
}

extension GameListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getGamesCount()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return one
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as? GameListTableViewCell, let model = viewModel.getGames(at: indexPath.section) else { return UITableViewCell() }
        cell.configureCell(game: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

extension GameListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: GameDetailViewController.self)) as? GameDetailViewController else { return }
        detailVC.gameId = viewModel.getGamesId(at: indexPath.section)
        self.navigationController?.pushViewController(detailVC, animated: true)
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = nil
        gameListTableView.scrollToRow(at: self.indexPath, at: UITableView.ScrollPosition.top, animated: true)
        gameListTableView.reloadData()
    }
}


