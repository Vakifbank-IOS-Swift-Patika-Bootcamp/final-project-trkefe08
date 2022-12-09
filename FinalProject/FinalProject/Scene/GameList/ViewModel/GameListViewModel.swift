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
    func nextFetchGamesList() 
}
//MARK: Delegate
protocol GameListViewModelDelegate: AnyObject {
    func gamesLoaded()
}

final class GameListViewModel: GameListViewModelProtocol {
    
    weak var delegate: GameListViewModelDelegate?
    private var games: [GameListResultModel]? = []
    private var pagination: Int = 1
    
    //MARK: Methods
    func fetchGamesList() {
        RawgDBClient.shared.getGamesList(with: pagination) { [weak self] result in
            switch result {
            case .success(let results):
                self?.games = results?.results
                self?.delegate?.gamesLoaded()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func nextFetchGamesList() {
        pagination += 1
        RawgDBClient.shared.getGamesList(with: pagination) { [weak self] result in
            switch result {
            case .success(let results):
                self?.games?.append(contentsOf: (results?.results)!)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func getGamesCount() -> Int {
        return games?.count ?? 0
    }
    
    func getGames(at index: Int) -> GameListResultModel? {
        return games?[index]
    }
    
    func getGamesId(at index: Int) -> Int? {
        games?[index].id
    }
    
}
