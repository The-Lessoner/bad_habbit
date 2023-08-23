//
//  SignInAppleViewController.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 14.07.23.
//

import UIKit
import SnapKit
import AuthenticationServices

protocol SignInAppleViewProtocol: AnyObject { }

final class SignInAppleViewController: BaseViewController, SignInAppleViewProtocol {
    private lazy var authorizationButton = ASAuthorizationAppleIDButton()
    private lazy var imageLogo = UIImageView()
    private lazy var imageMountains = UIImageView()

    private let presenter: SignInApplePresenterProtocol

    init(presenter: SignInApplePresenterProtocol) {
        self.presenter = presenter
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension SignInAppleViewController {

    private func setupUI() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = String(localized: "appName")
        
        view.backgroundColor = Asset.Colors.background.color
        imageMountains = createImageView(name: Asset.Images.mountains.image)
        imageLogo = createImageView(name: Asset.Images.logo.image)
        imageLogo.alpha = 0.5
        imageLogo.contentMode = .scaleAspectFill
        createAuthorizationButton()
        setupConstraints()
    }

    private func createImageView(name: UIImage) -> UIImageView {
        let image = name
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        return imageView
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        imageLogo.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.centerY.equalTo(imageMountains.snp.top)
            make.size.equalTo(LayoutConstants.ImageLogo.size)
        }

        imageMountains.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.bottom.leading.trailing.equalToSuperview()
        }

        authorizationButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea).inset(LayoutConstants.ActionButton.bottomInset)
            make.height.equalTo(LayoutConstants.ActionButton.height)
            make.leading.trailing.equalTo(safeArea).inset(LayoutConstants.trailingInset)
        }
    }

    private func createAuthorizationButton() {
        view.addSubview(authorizationButton)
        authorizationButton.cornerRadius = 12
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }

    @objc
    private func handleAuthorizationAppleIDButtonPress() {
        presenter.authorizationButtonDidTap()
    }

}
