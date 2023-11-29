//
//  PriceForPackScreenAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 6.09.23.
//

import UIKit

final class PriceForPackScreenAssembly: StoryAssembly {
    
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
        let router = PriceForPackScreenRouter(
            emptyScreenAssembly: nextScreen,
            globalCoordinator: globalCoordinator
        )
        let presenter = PriceForPackScreenPresenter(
            router: router,
            persistentContainer: persistentContainer
        )
        
        let view = PriceForPackViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
