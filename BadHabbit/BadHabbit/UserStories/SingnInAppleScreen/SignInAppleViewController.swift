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
    private lazy var titleLabel = UILabel()
    private lazy var imageLogo = UIImageView()
    private lazy var imageMountains = UIImageView()

    private let presenter: SignInApplePresenterProtocol?

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
        view.backgroundColor = UIColor(named: "backgroundColor")
        imageMountains = createImageView(name: "mountains")
        imageLogo = createImageView(name: "logo")
        imageLogo.contentMode = .scaleAspectFill
        createAuthorizationButton()
        createTitleLabel()
        setupConstraints()
    }

    private func createImageView(name: String) -> UIImageView {
        let imageName = name
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        return imageView
    }

    private func createTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: Font.SFProDisplayBold.rawValue, size: 24)
        titleLabel.text = String(localized: "appTitle").uppercased()
        titleLabel.textAlignment = .center
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).inset(35)
            make.leading.trailing.equalToSuperview().inset(LayoutConstants.leadingOffset)
        }

        imageLogo.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.centerY.equalTo(imageMountains.snp.top)
            make.size.equalTo(LayoutConstants.ImageLogo.width)
        }

        imageMountains.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.bottom.leading.trailing.equalToSuperview()
        }

        authorizationButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea).inset(LayoutConstants.ActionButton.bottomOffset)
            make.height.equalTo(LayoutConstants.ActionButton.height)
            make.leading.trailing.equalTo(safeArea).inset(LayoutConstants.trailingOffset)
        }
    }

    private func createAuthorizationButton() {
        view.addSubview(authorizationButton)
        authorizationButton.cornerRadius = 12
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }

    @objc
    private func handleAuthorizationAppleIDButtonPress() {
        presenter?.authorizationButtonDidTap()
    }

}
