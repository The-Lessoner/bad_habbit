//
//  AppAssembly.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.07.23.
//

import UIKit

final class AppAssembly {
    
    private(set) lazy var storiesAssembly = StoriesAssembly(
        designKitAssembly: designKitAssembly,
        persistentKitAssembly: persistenceKitAssembly
    )
    
    private(set) lazy var designKitAssembly = DesignKitAssembly(
        application: application,
        window: window
    )
    
    private(set) lazy var persistenceKitAssembly = PersistentKitAssembly(
        persistentContainerName: persistentContainerName
    )
    
    private let application: UIApplication
    private let window: UIWindow
    private let persistentContainerName: String
    
    init(
        application: UIApplication,
        window: UIWindow,
        persistentContainerName: String
    ) {
        self.application = application
        self.window = window
        self.persistentContainerName = persistentContainerName
    }
}
