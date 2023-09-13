//
//  SignUpScreenPresenter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 24/07/2023.
//

import UIKit

protocol SignUpScreenPresenterProtocol {
    var numberOfItems: Int { get }
    
    func startButtonTapped()
    func image(forRow row: Int) -> UIImage
}

final class SignUpScreenPresenter: SignUpScreenPresenterProtocol {
    private let router: SignUpRouterProtocol
    private var images: [UIImage] = {
        var image: [UIImage] = []
        (1...3).forEach { _ in
            image.append(Assets.Images.signUpScreenLogo.image)
        }
        
        return image
    }()
    
    weak var view: SignUpViewProtocol?
    var numberOfItems: Int { images.count }
    
    init(router: SignUpRouterProtocol) {
        self.router = router
    }
    
    func startButtonTapped() {
        router.presentSignInAppleScreen()
    }
    
    func image(forRow row: Int) -> UIImage {
        images[row]
    }
}
