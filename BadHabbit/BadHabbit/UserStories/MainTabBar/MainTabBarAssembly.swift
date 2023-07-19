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
        let secondVC = SignInAppleViewController()
        secondVC.tabBarItem.title = "second"
        
        tabVC.setViewControllers(
            [
                exampleVC,
                secondVC
            ],
            animated: true
        )
        
        return tabVC
    }
}
