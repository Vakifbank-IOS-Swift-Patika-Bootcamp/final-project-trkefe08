//
//  GameListViewModel.swift
//  FinalProject
//
//  Created by Tarik Efe on 6.12.2022.
//

import Foundation
//MARK: Protocol
protocol GameListViewModelProtocol {
    var delegate: GameListViewModelDelegate? { get set }
    func fetchGamesList()
    func getGamesCount() -> Int
    func getGames(at index: Int) -> GameListResultModel?
    func getGamesId(at index: Int) -> Int?
}
//MARK: Delegate
protocol GameListViewModelDelegate: AnyObject {
    func gamesLoaded()
}

final class GameListViewModel: GameListViewModelProtocol {
    weak var delegate: GameListViewModelDelegate?
    private var games: [GameListResultModel]?
    
    //MARK: Methods
    func fetchGamesList() {
        RawgDBClient.shared.getGamesList { [weak self] result in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self?.games = results
                    self?.delegate?.gamesLoaded()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(String(describing: error))
                }
            }
        }
    }
    
    func getGamesCount() -> Int {
        games?.count ?? 0
    }
    
    func getGames(at index: Int) -> GameListResultModel? {
        games?[index]
    }
    
    func getGamesId(at index: Int) -> Int? {
        games?[index].id
    }
    
}
