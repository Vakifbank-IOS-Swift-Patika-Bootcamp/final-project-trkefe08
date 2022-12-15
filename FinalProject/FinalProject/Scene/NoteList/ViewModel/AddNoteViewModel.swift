//
//  AddNoteViewModel.swift
//  FinalProject
//
//  Created by Tarik Efe on 15.12.2022.
//

import UIKit

protocol AddNoteViewModelProtocol {
    var delegate: AddNoteViewModelDelegate? { get set }
    func fetchAllGames()
}

protocol AddNoteViewModelDelegate: AnyObject {
    func gameLoaded()
}

//MARK: - Class
final class AddNoteViewModel: AddNoteViewModelProtocol {
    
    //MARK: - Variables
    weak var delegate: GameDetailViewModelDelegate?
    private var games = [GameListResultModel]?
    
    //MARK: - Methods
    func fetchAllGames() {
        RawgDBClient.shared.getGamesList { [weak self] result in
            switch result {
            case .success(let results):
                self?.games = results?.results
                self?.delegate?.gamesLoaded()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
