//
//  NoteCoreDataManager.swift
//  FinalProject
//
//  Created by Tarik Efe on 15.12.2022.
//

import UIKit
import CoreData

enum GameCoreDataKeys: String {
    case noteId
    case note
    case gameId
}

final class NoteCoreDataManager {
    static let shared = NoteCoreDataManager()
    private var coreDataStack: CoreDataStack
    private var managedContext: NSManagedObjectContext!
    
    private init(coreDataStack: CoreDataStack = CoreDataStack(entityName: "Note")) {
        self.coreDataStack = coreDataStack
    }
    
    @discardableResult
    func saveNote(noteText: String, game gameId: Int) -> Note? {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(UUID(), forKey: GameCoreDataKeys.noteId.rawValue)
        note.setValue(noteText, forKeyPath: GameCoreDataKeys.note.rawValue)
        note.setValue(gameId, forKey: GameCoreDataKeys.gameId.rawValue)
        
        do {
            try managedContext.save()
            return note as? Note
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [Note]
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func deleteNoteBy(id noteId: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "noteId = %@", noteId.uuidString)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                managedContext.delete(result)

                do  {
                    try managedContext.save()
                } catch {
                    print("Could not save. \(error)")
                }
                break
            }
        } catch {
            print("Could not delete. \(error)")
        }
    }
    
    func getNoteBy(id noteId: UUID) -> Note? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "noteId = %@", noteId.uuidString)
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                return result as? Note
            }
        } catch {
            print("Could not delete. \(error)")
        }
        
        return nil
    }
    
    func updateNoteBy(id noteId: UUID, newGameId: Int, newNote: String) {
        var note = getNoteBy(id: noteId)
        guard let note = note else { return }
        note.gameId = Int32(newGameId)
        note.note = String(newNote)
        
        do {
            try managedContext.save()
        }
        catch {
            print("Could not update. \(error)")
        }
    }
}
