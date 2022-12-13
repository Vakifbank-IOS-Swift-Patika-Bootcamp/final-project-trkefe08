//
//  CoreDataManager.swift
//  FinalProject
//
//  Created by Tarik Efe on 13.12.2022.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private var coreDataStack: CoreDataStack
    private var nsCore: NSManagedObjectContext {
        return coreDataStack.managedContext
    }
    
    private init(coreDataStack: CoreDataStack = CoreDataStack(entityName: "FinalProject")) {
        self.coreDataStack = coreDataStack
    }
    
    private func gameIdVerify(of request: NSFetchRequest<FinalProject>, with id: Int) -> NSPredicate {
        request.predicate = NSPredicate(format: "id == %d", id)
        return request.predicate!
    }
    
    func checkIsFavourite(with gameId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            let request: NSFetchRequest<FinalProject> = FinalProject.fetchRequest()
            request.returnsObjectsAsFaults = false
            request.predicate = gameIdVerify(of: request, with: gameId)
            let fetchedResults = try nsCore.fetch(request)
            fetchedResults.first != nil ? completion(.success(true)) : completion(.success(false))
        } catch {
            completion(.failure(error))
        }
    }
    
    func getFavoriteGamesFromCoreData(completion: @escaping (Result<[FinalProject], Error>) -> Void) {
        do {
            let request: NSFetchRequest<FinalProject> = FinalProject.fetchRequest()
            request.returnsObjectsAsFaults = false
            let games = try nsCore.fetch(request)
            completion(.success(games))
        } catch {
            completion(.failure(error))
        }
    }
    
    func createFavoriteGame(with gameResult: GameDetailModel) {
        let favoriteGame = FinalProject(context: nsCore)
        favoriteGame.id = Int64(gameResult.id ?? 0)
        favoriteGame.name = gameResult.name
        favoriteGame.rating = Double(gameResult.rating ?? 0)
        favoriteGame.topRating = Int64(gameResult.ratingTop ?? 0)
        favoriteGame.image = gameResult.backgroundImage
        favoriteGame.releaseDate = gameResult.released
        coreDataStack.saveContext()
    }
    
    func deleteGame(with gameId: Int, completion: @escaping (Error) -> Void) {
        let request: NSFetchRequest<FinalProject> = FinalProject.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.predicate = gameIdVerify(of: request, with: gameId)
        do {
            let fetchedResult = try nsCore.fetch(request)
            if let gameModel = fetchedResult.first {
                nsCore.delete(gameModel)
                coreDataStack.saveContext()
            }
        } catch {
            completion(error)
        }
    }
}
