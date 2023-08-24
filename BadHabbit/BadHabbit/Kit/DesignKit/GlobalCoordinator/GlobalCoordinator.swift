//
//  GlobalCoordinator.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 21.07.23.
//

import UIKit

protocol IGlobalCoordinator {
    func presentOnTopVisibleViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: VoidClosure?
    )
    
    func presentOnTopVisibleViewController(_ viewController: UIViewController)
    
    func pushViewController(_ viewController: UIViewController)
}

final class GlobalCoordinator: IGlobalCoordinator {
    
    private var window: UIWindow? {
        if let initialWindow, initialWindow.isKeyWindow {
            return initialWindow
        } else {
            return activeWindow()
        }
    }

    private let application: UIApplication
    private let initialWindow: UIWindow?
    
    init(application: UIApplication, initialWindow: UIWindow?) {
        self.application = application
        self.initialWindow = initialWindow
    }
    
    func presentOnTopVisibleViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: VoidClosure?
    ) {
        guard let topVC = topVisibleViewController(viewController) else {
            assertionFailure()
            return
        }
        topVC.present(viewController, animated: animated, completion: completion)
    }

    private func topVisibleViewController(_ viewController: UIViewController) -> UIViewController? {
        guard let window = self.window else {
            assertionFailure()
            return nil
        }

        guard let topVC = topViewController(on: window.rootViewController) else {
            assertionFailure()
            return nil
        }

        return topVC
    }

    func presentOnTopVisibleViewController(_ viewController: UIViewController) {
        presentOnTopVisibleViewController(viewController, animated: true, completion: nil)
    }
    
    private func activeWindow() -> UIWindow? {
        let scene = application.connectedScenes.first(where: { scene in
            scene.activationState == .foregroundActive && scene is UIWindowScene
        })
        
        guard let scene = scene as? UIWindowScene else {
            return nil
        }
        
        let window = scene.windows.first(where: { $0.isKeyWindow })
        
        return window
    }
    
    private func topViewController(on viewController: UIViewController?) -> UIViewController? {
        if viewController?.presentedViewController != nil {
            return topViewController(on: viewController?.presentedViewController)
        }
        
        switch viewController {
        case let tabVC as UITabBarController:
            return topViewController(on: tabVC.selectedViewController)
            
        case let navVC as UINavigationController:
            return topViewController(on: navVC.topViewController)

        default:
            return viewController
        }
    }

    func pushViewController(_ viewController: UIViewController) {
        guard let topVC = topVisibleViewController(viewController) else {
            assertionFailure()
            return
        }

        topVC.navigationController?.pushViewController(viewController, animated: true)
    }
}
