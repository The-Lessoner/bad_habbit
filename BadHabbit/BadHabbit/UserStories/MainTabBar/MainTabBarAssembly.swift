//
//  MainTabBarAssembly.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import UIKit

final class MainTabBarAssembly {
    
    private let exampleScreenAssembly: ViewAssembly
    
    init(
        exampleScreenAssembly: ViewAssembly
    ) {
        self.exampleScreenAssembly = exampleScreenAssembly
    }
    
    func assemble() -> UIViewController {
        let tabVC = UITabBarController()
        
        let exampleVC = exampleScreenAssembly.assembleView()
        exampleVC.tabBarItem.title = "Example"
        let signInVC = SignInViewController()
        signInVC.tabBarItem.title = "Sign In"
        
        tabVC.setViewControllers(
            [
                exampleVC,
                signInVC
            ],
            animated: true
        )
        tabVC.tabBar.unselectedItemTintColor = .blue
        return tabVC
    }
}
