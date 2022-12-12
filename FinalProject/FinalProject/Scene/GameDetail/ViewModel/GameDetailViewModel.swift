//
//  GameDetailViewModel.swift
//  FinalProject
//
//  Created by Tarik Efe on 11.12.2022.
//

import UIKit
//MARK: Protocols
protocol GameDetailViewModelProtocol {
    var delegate: GameDetailViewModelDelegate? { get set }
    func fetchGameDetail(id: Int)
    func getGameImageURL() -> URL?
    func getGameTitle() -> String
    func getGameDescription() -> String
    func getGameRelease() -> String
    func getRating() -> Double
    func getTopRating() -> Int
}

protocol GameDetailViewModelDelegate: AnyObject {
    func gameLoaded()
}
//MARK: Class
final class GameDetailViewModel: GameDetailViewModelProtocol {
    //MARK: Variables
    weak var delegate: GameDetailViewModelDelegate?
    private var game: GameDetailModel?
    private var gameMeta: MetaModel?
    
    //MARK: Methods
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
    
    func fetchMetaModel(id: Int) {
        RawgDBClient.shared.getMetaModel(with: id) { [weak self] result in
            switch result {
            case .success(let results):
                self?.gameMeta = results
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
        game?.gameDetailModelDescription ?? "Not Found"
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
        gameMeta?.metascore ?? 0
    }
}
