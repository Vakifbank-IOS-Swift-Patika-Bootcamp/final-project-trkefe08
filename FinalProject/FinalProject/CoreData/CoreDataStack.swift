//
//  CoreDataStack.swift
//  FinalProject
//
//  Created by Tarik Efe on 13.12.2022.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    private let entityName: String
    
    init(entityName: String) {
        self.entityName = entityName
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: entityName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        let context = storeContainer.viewContext
        return context
    }()
    
    func saveContext () {
        guard managedContext.hasChanges else {
            return
        }
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

