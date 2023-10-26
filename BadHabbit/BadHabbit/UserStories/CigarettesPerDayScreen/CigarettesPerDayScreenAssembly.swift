//
//  CigarettesPerDayScreenAssembly.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 17/09/2023.
//

import UIKit

final class CigarettesPerDayScreenAssembly: StoryAssembly {
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
        let router = CigarettesPerDayScreenRouter(
            cigarettesInPackScreenAssembly: nextScreen,
            globalCoordinator: globalCoordinator
        )
        
        let presenter = CigarettesPerDayScreenPresenter(
            router: router,
            persistentContainer: persistentContainer
        )
        
        let view = CigarettesPerDayViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
