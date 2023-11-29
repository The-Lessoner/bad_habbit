//
//  PersistantContainer.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 31.10.23.
//

import CoreData

protocol PersistentContainerProtocol {
    var context: NSManagedObjectContext { get }

    func fetch<Entity>(request: NSFetchRequest<Entity>) -> [NSFetchRequestResult] where Entity: NSFetchRequestResult
    func saveContext(backgroundContext: NSManagedObjectContext?)
}

final class PersistentContainer: NSPersistentContainer, PersistentContainerProtocol {
    var context: NSManagedObjectContext {
        viewContext
    }

    override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)

        loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent store: \(error)")
            }
        }
    }

    func fetch<Entity>(request: NSFetchRequest<Entity>) -> [NSFetchRequestResult] where Entity: NSFetchRequestResult {
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
    }

    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? context

        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
