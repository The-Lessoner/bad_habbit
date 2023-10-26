//
//  PersistentKitAssembly.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 29/09/2023.
//

import CoreData

final class PersistentKitAssembly {
    var persistentContainer: PersistentContainerProtocol
    
    init(persistentContainerName: String) {
        persistentContainer = PersistentContainer(name: persistentContainerName)
    }
}
