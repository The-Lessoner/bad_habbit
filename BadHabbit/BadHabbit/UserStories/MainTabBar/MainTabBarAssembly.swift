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
        
        lazy var serviceAssemblySecondScreen = ServiceAssembly(
            requestExecutor: RequestExecutor(config: RequestExecutor.Config(scheme: Constants.APIDetails.scheme, host: Constants.APIDetails.host) )
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
        tabVC.tabBar.unselectedItemTintColor = .gray
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        
        return tabVC
    }
}
