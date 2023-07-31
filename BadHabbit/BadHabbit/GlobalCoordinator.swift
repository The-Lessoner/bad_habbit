//
//  GlobalCoordinator.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.
//

import UIKit

protocol IGlobalCoordinator {
    func presentOnTopVisibleViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: VoidClosure?
    )
    func presentOnTopVisibleViewController(_ viewController: UIViewController)
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
        guard let window = self.window else {
            assertionFailure()
            return
        }

        guard let topVC = topViewController(on: window.rootViewController) else {
            assertionFailure()
            return
        }

        topVC.present(viewController, animated: animated, completion: completion)
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

    func presentOnTopVisibleViewController(_ viewController: UIViewController) {
        presentOnTopVisibleViewController(viewController, animated: true, completion: nil)
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
}
