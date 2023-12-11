//
//  PersistentKitAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 31.10.23.
//

import CoreData

final class PersistentKitAssembly {
    var persistentContainer: PersistentContainerProtocol

    init(persistentContainerName: String) {
        persistentContainer = PersistentContainer(name: persistentContainerName)
    }
}
