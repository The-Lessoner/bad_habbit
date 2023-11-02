//
//  CigarettesInPackScreenAssembly.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 27/09/2023.
//

import UIKit

final class CigarettesInPackScreenAssembly: StoryAssembly {
    private let nextScreen: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    private let persistentContainer: PersistentContainerProtocol
    
    init(
        nextScreen: StoryAssembly,
        globalCoordinator: IGlobalCoordinator,
        persistentContainer: PersistentContainerProtocol
    ) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
        self.persistentContainer = persistentContainer
    }
    
    func assembleStory() -> UIViewController {
        let router = CigarettesInPackScreenRouter(
            emptyScreenAssembly: nextScreen,
            globalCoordinator: globalCoordinator
        )
        let presenter = CigarettesInPackScreenPresenter(
            router: router,
            persistentContainer: persistentContainer
        )
        let view = CigarettesInPackViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
