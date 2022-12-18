//
//  AddNoteViewModel.swift
//  FinalProject
//
//  Created by Tarik Efe on 15.12.2022.
//

import UIKit

protocol AddNoteViewModelProtocol {
    var delegate: AddNoteViewModelDelegate? { get set }
    func getNoteCount() -> Int
    func getNote(at index: Int) -> Note?
    func getGameId(at index: Int) -> String?
    func saveNote(note: String, id: String)
    func updateNote(id: UUID, newGame: String, newNote: String)
    func deleteNote(id: UUID)
    func getNotes() -> [Note]
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
    func getNoteCount() -> Int {
        notes.count
    }
    
    func getNote(at index: Int) -> Note? {
        notes[index]
    }
    
    func getGameId(at index: Int) -> String? {
        notes[safe: index]?.game
    }
    
    func saveNote(note: String, id: String) {
        NoteCoreDataManager.shared.saveNote(noteText: note, game: id)
    }
    
    func updateNote(id: UUID, newGame: String, newNote: String) {
        NoteCoreDataManager.shared.updateNoteBy(id: id, newGame: newGame, newNote: newNote)
    }
    
    func deleteNote(id: UUID) {
        NoteCoreDataManager.shared.deleteNoteBy(id: id)
    }
    
    func getNotes() -> [Note] {
        NoteCoreDataManager.shared.getNotes()
    }
    
    
}
