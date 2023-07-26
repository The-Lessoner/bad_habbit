//
//  AppAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.
//

import UIKit

final class AppAssembly {

    private(set) lazy var designKitAssembly = DesignKitAssembly(
        application: application,
        window: window
    )

    private(set) lazy var storiesAssembly = StoriesAssembly(
        designKitAssembly: designKitAssembly
    )

    private let application: UIApplication
    private let window: UIWindow

    init(application: UIApplication, window: UIWindow) {
        self.application = application
        self.window = window
    }
}
