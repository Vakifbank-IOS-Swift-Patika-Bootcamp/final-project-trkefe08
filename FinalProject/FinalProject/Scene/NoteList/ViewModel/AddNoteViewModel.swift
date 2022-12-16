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
    //func fetchGameId(with id: Int)
    func getNoteCount() -> Int
    func getNote(at index: Int) -> Note?
    func getGameId(at index: Int) -> Int32?
    func saveNote(note: String, id: Int)
    func updateNote(id: UUID, newGameId: Int, newNote: String)
}

protocol AddNoteViewModelDelegate: AnyObject {
    func gameLoaded()
}

//MARK: - Class
final class AddNoteViewModel: AddNoteViewModelProtocol {
    
    //MARK: - Variables
    weak var delegate: AddNoteViewModelDelegate?
    private var games: [GameListResultModel]?
    var notes: [Note] = [] {
        didSet {
            delegate?.gameLoaded()
        }
    }
    
    //MARK: - Methods
    func fetchAllGames() {
        RawgDBClient.shared.getGamesList { [weak self] result in
            switch result {
            case .success(let results):
                self?.games = results?.results
                self?.delegate?.gameLoaded()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /* func fetchGameId(with id: Int) {
     RawgDBClient.shared.getGameDetail(with: id) { [weak self] result in
     switch result {
     case .success(let results):
     self?.games = results?.results
     self?.delegate?.gamesLoaded()
     case .failure(let error):
     print(String(describing: error)) in
     }
     }
     }*/
    
    func getNoteCount() -> Int {
        notes.count
    }
    
    func getNote(at index: Int) -> Note? {
        notes[index]
    }
    
    func getGameId(at index: Int) -> Int32? {
        notes[safe: index]?.gameId
    }
    
    func saveNote(note: String, id: Int) {
        NoteCoreDataManager.shared.saveNote(noteText: note, game: id)
    }
    
    func updateNote(id: UUID, newGameId: Int, newNote: String) {
        NoteCoreDataManager.shared.updateNoteBy(id: id, newGameId: newGameId, newNote: newNote)
    }
    
    
}
