//
//  SignUpScreenPresenter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 24/07/2023.
//

import UIKit

protocol SignUpScreenPresenterProtocol {
    func startButtonTapped()
    func pageControlPageChanged(toPage: Int)
    func logoImageViewSwiped(_ swipeDirection: UISwipeGestureRecognizer.Direction, currentPageControlPage page: Int)
}

final class SignUpScreenPresenter: SignUpScreenPresenterProtocol {
    
    weak var view: SignUpViewProtocol?
    private let router: SignUpRouterProtocol
    
    init(router: SignUpRouterProtocol) {
        self.router = router
    }
    
    func logoImageViewSwiped(_ swipeDirection: UISwipeGestureRecognizer.Direction, currentPageControlPage page: Int) {
        let nextPage: Int
        
        switch swipeDirection {
        case .left:
            nextPage = page + 1
        case .right:
            nextPage = page - 1
        default: return
        }
        
        if (0...2).contains(nextPage) {
            view?.updatePageControlPage(toPage: nextPage)
        }
    }
    
    func pageControlPageChanged(toPage page: Int) {
        guard let image = image(forPage: page)
        else { return }
        
        let buttonIsEnabled = startButtonIsEnabled(onPage: page)
        let buttonBackgroundColor = startButtonBackgroundColor(forPage: page)
        
        view?.updateLogoImageViewImage(image)
        view?.updateStartButtonEnabledState(buttonIsEnabled)
        view?.updateStartButtonBackgroundColor(buttonBackgroundColor)
    }
    
    func startButtonTapped() {
        router.presentSignInAppleScreen()
    }
    
    private func image(forPage page: Int) -> UIImage? {
        var image: UIImage?
        
        switch page {
        case 0, 1, 2:
            image = UIImage(named: "signUpScreenLogo")
        default: break
        }
        
        return image
    }
    
    private func startButtonIsEnabled(onPage page: Int) -> Bool {
        if page == 2 {
            return true
        } else {
            return false
        }
    }
    
    private func startButtonBackgroundColor(forPage page: Int) -> UIColor? {
        let colorName: String
        
        if page == 2 {
            colorName = "startButtonBaseBackgroundColor"
        } else {
            colorName = "startButtonUnenabledBackgroundColor"
        }
        
        return UIColor(named: colorName)
    }
}
