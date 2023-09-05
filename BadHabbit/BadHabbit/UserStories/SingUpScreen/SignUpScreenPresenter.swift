//
//  SignUpScreenPresenter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 24/07/2023.
//

import UIKit

protocol SignUpScreenPresenterProtocol {
    var cellCount: Int { get }
    var images: [UIImage] { get }
    
    func startButtonTapped()
    func pageControlPageChanged(toPage: Int)
    func collectionViewSwiped(toItemAt visibleItem: Int)
}

final class SignUpScreenPresenter: SignUpScreenPresenterProtocol {
    weak var view: SignUpViewProtocol?
    
    lazy var cellCount: Int = {
        return 3
    }()
    
    lazy var images: [UIImage] = {
        var image: [UIImage] = []
        (1...3).forEach { _ in
            image.append(Assets.Images.signUpScreenLogo.image)
        }
        
        return image
    }()
    
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
    
    func collectionViewSwiped(toItemAt visibleItem: Int) {
        view?.updatePageControlPage(toPage: visibleItem)
        isNeedStartButtonUpdate(forPage: visibleItem)
    }
    
    func pageControlPageChanged(toPage page: Int) {
        view?.updateCollectionView(toPage: page)
        isNeedStartButtonUpdate(forPage: page)
    }
    
    func startButtonTapped() {
        router.presentSignInAppleScreen()
    }
    
    private func isNeedStartButtonUpdate(forPage page: Int) {
        if page == 2 && startButtonIsEnabled == false {
            startButtonIsEnabled = true
        }
    }
}
