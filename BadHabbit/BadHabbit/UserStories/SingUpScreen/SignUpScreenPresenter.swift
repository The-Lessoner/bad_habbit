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
    func logoImageViewSwiped(_ swipeDirection: UISwipeGestureRecognizer.Direction, pageControlCurrentPage page: Int)
}

final class SignUpScreenPresenter: SignUpScreenPresenterProtocol {
    
    weak var view: SignUpViewProtocol?
    private let router: SignUpRouterProtocol
    private var startButtonIsEnabled = false {
        didSet {
            view?.updateStartButton(
                isEnabled: self.startButtonIsEnabled
            )
        }
    }
    
    init(router: SignUpRouterProtocol) {
        self.router = router
    }
    
    func logoImageViewSwiped(_ swipeDirection: UISwipeGestureRecognizer.Direction, pageControlCurrentPage page: Int) {
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
            pageControlPageChanged(toPage: nextPage)
        }
    }
    
    func pageControlPageChanged(toPage page: Int) {
        guard let image = image(forPage: page)
        else { return }
        
        view?.updateLogoImageViewImage(image)
        
        if page == 2 && startButtonIsEnabled == false {
            startButtonIsEnabled = true
        }
    }
    
    func startButtonTapped() {
        router.presentSignInAppleScreen()
    }
    
    private func image(forPage page: Int) -> UIImage? {
        var image: UIImage?
        
        switch page {
        case 0, 1, 2:
            image = Assets.Images.signUpScreenLogo.image
        default: break
        }
        
        return image
    }
}
