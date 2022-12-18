//
//  FavoriteListViewModel.swift
//  FinalProject
//
//  Created by Tarik Efe on 13.12.2022.
//

import Foundation

//MARK: - Protocol
protocol FavoriteListViewModelProtocol {
    var delegate: FavoriteListViewModelDelegate? { get set }
    func fetchGamesFromCoreData()
    func getFavoriteGameCount() -> Int
    func getFavorite(at index: Int) -> FinalProject?
    func getFavoriteId(at index: Int) -> Int64?
    func deleteFavoriteGame(with favoriteId: Int)
}
//MARK: - Delegate
protocol FavoriteListViewModelDelegate: AnyObject {
    func favoritesLoaded()
}

//MARK: - Class
final class FavoriteListViewModel: FavoriteListViewModelProtocol {
    weak var delegate: FavoriteListViewModelDelegate?
    var favoriteGames: [FinalProject] = [] {
        didSet {
            delegate?.favoritesLoaded()
        }
    }
    
    //MARK: - Methods
    func fetchGamesFromCoreData() {
        CoreDataManager.shared.getFavoriteGamesFromCoreData { result in
            switch result {
            case .success(let favorites):
                self.favoriteGames = favorites
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getFavoriteGameCount() -> Int {
        favoriteGames.count
    }
    
    func getFavorite(at index: Int) -> FinalProject? {
        favoriteGames[index]
    }
    
    func getFavoriteId(at index: Int) -> Int64? {
        favoriteGames[safe: index]?.id
    }
    
    func deleteFavoriteGame(with favoriteId: Int) {
        CoreDataManager.shared.deleteGame(with: favoriteId) { error in
            print(error)
        }
        guard let id = favoriteGames.indices.first(where: { index  in
            return favoriteGames[index].id == favoriteId
        }) else { return }
        self.favoriteGames.remove(at: id)
    }
}
