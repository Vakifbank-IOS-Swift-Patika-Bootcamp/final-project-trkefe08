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
    
    private var viewModel: GameListViewModelProtocol = GameListViewModel()
    
//MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchGamesList()
    }
}

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
