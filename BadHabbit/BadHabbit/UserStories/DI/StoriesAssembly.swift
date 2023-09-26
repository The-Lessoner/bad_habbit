//
//  StoriesAssembly.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import Foundation
import UIKit

final class StoriesAssembly {
    
    private let designKitAssembly: DesignKitAssembly
    
    init(designKitAssembly: DesignKitAssembly) {
        self.designKitAssembly = designKitAssembly
    }
    
    var signUpScreen: StoryAssembly {
        SignUpScreenAssembly(
            nextScreen: signInScreen,
            globalCoordinator: designKitAssembly.globalCoordinator
        )
    }

    var signInScreen: StoryAssembly {
        SignInAppleAssembly(
            nextScreen: self.breakHabitScreen,
            globalCoordinator: designKitAssembly.globalCoordinator
        )
    }

    var breakHabitScreen: StoryAssembly {
        BreakHabitScreenAssembly(
            nextScreen: cigarettesPerDayScreen,
            globalCoordinator: designKitAssembly.globalCoordinator
        )
    }
    
    var cigarettesPerDayScreen: StoryAssembly {
        CigarettesPerDayScreenAssembly(
            nextScreen: emptyScreen,
            globalCoordinator: designKitAssembly.globalCoordinator
        )
    }
    
    var emptyScreen: StoryAssembly {
        EmptyScreenAssembly()
    }
}
