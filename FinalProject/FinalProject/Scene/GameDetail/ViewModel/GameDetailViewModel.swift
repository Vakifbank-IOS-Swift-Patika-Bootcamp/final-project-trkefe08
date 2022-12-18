//
//  GameDetailViewModel.swift
//  FinalProject
//
//  Created by Tarik Efe on 11.12.2022.
//

import UIKit
//MARK: - Protocols
protocol GameDetailViewModelProtocol {
    var delegate: GameDetailViewModelDelegate? { get set }
    func fetchGameDetail(id: Int)
    func getGameImageURL() -> URL?
    func getGameTitle() -> String
    func getGameDescription() -> String
    func getGameRelease() -> String
    func getRating() -> Double
    func getTopRating() -> Int
    func getMetaScore() -> Int
    func addFavorite(id: Int)
    func showFavorite(id: Int)
}

protocol GameDetailViewModelDelegate: AnyObject {
    func gameLoaded()
    func didAddFavorite(status: Bool)
}
//MARK: - Class
final class GameDetailViewModel: GameDetailViewModelProtocol {
    
    //MARK: - Variables
    weak var delegate: GameDetailViewModelDelegate?
    private var game: GameDetailModel?
    
    //MARK: - Methods
    func fetchGameDetail(id: Int) {
        RawgDBClient.shared.getGameDetail(with: id) { [weak self] result in
            switch result {
            case .success(let results):
                self?.game = results
                self?.delegate?.gameLoaded()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func getGameImageURL() -> URL? {
        URL(string: game?.backgroundImage ?? "")
    }
    
    func getGameTitle() -> String {
        game?.name ?? "Not Found"
    }
    
    func getGameDescription() -> String {
        game?.descriptionRaw ?? "Not Found"
    }
    
    func getGameRelease() -> String {
        game?.released ?? "Not Found"
    }
    
    func getRating() -> Double {
        game?.rating ?? 0.0
    }
    
    func getTopRating() -> Int {
        game?.ratingTop ?? 0
    }
    
    func getMetaScore() -> Int {
        game?.metacritic ?? 0
    }
    
    func addFavorite(id: Int) {
        CoreDataManager.shared.checkIsFavorite(with: id) { result in
            switch result {
            case .success(let bool):
                self.delegate?.didAddFavorite(status: bool)
                if bool {
                    CoreDataManager.shared.deleteGame(with: id) { error in
                        print(error)
                    }
                    
                } else {
                    guard let games = self.game else { return }
                    CoreDataManager.shared.createFavoriteGame(with: games)
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func showFavorite(id: Int) {
        CoreDataManager.shared.checkIsFavorite(with: id) { result in
            switch result {
            case .success(let bool):
                if bool {
                    self.delegate?.didAddFavorite(status: bool)
                } else {
                    self.delegate?.didAddFavorite(status: bool)
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}
