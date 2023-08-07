//
//  StoriesAssembly.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import Foundation

final class StoriesAssembly {
    
    private let designKitAssembly: DesignKitAssembly
    
    init(designKitAssembly: DesignKitAssembly) {
        self.designKitAssembly = designKitAssembly
    }
    
    var signUpScreen: StoryAssembly {
        SignUpScreenAssembly(
            nextScreen: self.fillingPersonalData,
            globalCoordinator: designKitAssembly.globalCoordinator
        )
    }
    
    var fillingPersonalData: StoryAssembly {
        FillingPersonalDataAssembly(
            alertAssembly: designKitAssembly.alertAssembly
        )
    }
}
