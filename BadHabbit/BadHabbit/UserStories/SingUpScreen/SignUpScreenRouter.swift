//
//  SignUpScreenRouter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 24/07/2023.
//

import Foundation
import UIKit

protocol SignUpRouterProtocol {
    func presentSignInAppleScreen()
}

final class SignUpScreenRouter: SignUpRouterProtocol {
    
    let signInAppleScreenAssembly: StoryAssembly
    let globalCoordinator: IGlobalCoordinator
    
    init(
        signInAppleScreenAssembly: StoryAssembly,
        globalCoordinator: IGlobalCoordinator
    ) {
        self.signInAppleScreenAssembly = signInAppleScreenAssembly
        self.globalCoordinator = globalCoordinator
    }
    
    func presentSignInAppleScreen() {
        //    let vc = signInAppleScreenAssembly.assembleStory()
        let vc = UINavigationController(rootViewController: signInAppleScreenAssembly.assembleStory())
        vc.modalPresentationStyle = .fullScreen
        vc.navigationController?.pushViewController(vc, animated: true)
        // globalCoordinator.presentOnTopVisibleViewController(vc)
    }
}
