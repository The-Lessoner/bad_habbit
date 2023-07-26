//
//  DesignKitAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.


import UIKit

final class DesignKitAssembly {

    private let application: UIApplication
    private let window: UIWindow

    init(application: UIApplication, window: UIWindow) {
        self.application = application
        self.window = window
    }

    var alertAssembly: AlertAssemblyProtocol {
        AlertAssembly(
            globalCoordinator: globalCoordinator
        )
    }

    var globalCoordinator: IGlobalCoordinator {
        GlobalCoordinator(application: application, initialWindow: window)
    }
}
