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
        tabVC.tabBar.backgroundColor = .white
        let exampleVC = exampleScreenAssembly.assembleView()
        
        lazy var serviceAssemblySecondScreen = ServiceAssembly(
            requestExecutor: RequestExecutorSecondScreen(config: RequestExecutorSecondScreen.Config(baseURL: "https://www.hackingwithswift.com/samples/petitions-1.json") )
        )
        lazy var viewModelSecondScreenAssembly = ViewModelAssembly(serviceAssembly: serviceAssemblySecondScreen)
        let secondVC = SecondViewControllerAssembly(viewModelAssembly: viewModelSecondScreenAssembly).assembleView()
        
        exampleVC.tabBarItem.title = "Example"
        secondVC.tabBarItem.title = "SecondVC"
        
        tabVC.setViewControllers(
            [
                exampleVC,
                secondVC
            ],
            animated: true
        )
        let appearance = UITabBarItem.appearance()
        
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        return tabVC
    }
}
