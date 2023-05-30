//
//  SceneDelegate.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var serviceAssembly = ServiceAssembly(
        requestExecutor: RequestExecutorMock(requestResponseData: "{\"text\":\"Random Mocked text\"}".data(using: .utf8) ?? .init())
    )
    private lazy var newsServiceAssembly = NewsServiceAssembly(
        requestExecutor: NewsRequestExecutor(config: NewsRequestExecutor.Config(scheme: ProtocolType.https.rawValue, host: "newsapi.org"))
    )
        
    private lazy var viewModelAssembly = ViewModelAssembly(serviceAssembly: serviceAssembly)
    private lazy var newsViewModelAssembly = NewsViewModelAssembly(serviceAssembly: newsServiceAssembly)
    
    private lazy var rootTabBarAssembler: MainTabBarAssembly = {
        MainTabBarAssembly(
            exampleScreenAssembly: ExampleScreenAssembly(viewModelAssembly: viewModelAssembly),
            newsScreenAssembly: NewsScreenAssembly(viewModelAssembly: newsViewModelAssembly)
        )
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootTabBarAssembler.assemble()
        window.backgroundColor = .white
        
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

