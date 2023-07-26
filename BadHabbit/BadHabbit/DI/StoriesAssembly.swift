//
//  StoriesAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.
//

import Foundation

final class StoriesAssembly {

    private let designKitAssembly: DesignKitAssembly

    init(designKitAssembly: DesignKitAssembly) {
        self.designKitAssembly = designKitAssembly
    }

    var signInScreen: ViewAssembly {
        SignInDataAssembly(alertAssembly: designKitAssembly.alertAssembly, globalCoordinator: designKitAssembly.globalCoordinator)
    }

    var fillingPersonalData: ViewAssembly {
        FillingPersonalDataAssembly(
            alertAssembly: designKitAssembly.alertAssembly
        )
    }
}
