//
//  MainTabBarAssembly.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import UIKit

final class MainTabBarAssembly {
    
    private let exampleScreenAssembly: ViewAssembly
    private let newsScreenAssembly: ViewAssembly
    
    init(
        exampleScreenAssembly: ViewAssembly,
        newsScreenAssembly: ViewAssembly
    ) {
        self.exampleScreenAssembly = exampleScreenAssembly
        self.newsScreenAssembly = newsScreenAssembly
    }
    
    func assemble() -> UIViewController {
        let tabVC = UITabBarController()
        
        let exampleVC = exampleScreenAssembly.assembleView()
        exampleVC.tabBarItem.title = "Example"
        
        let newsVC = newsScreenAssembly.assembleView()
        newsVC.tabBarItem.title = "News"
        
        tabVC.setViewControllers(
            [
                exampleVC,
                newsVC
            ],
            animated: true
        )
        
        return tabVC
    }
}
