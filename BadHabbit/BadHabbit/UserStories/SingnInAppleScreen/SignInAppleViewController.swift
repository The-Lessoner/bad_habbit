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
    private lazy var imageLogo = UIImageView(image: Asset.Images.logo.image)
    private lazy var imageMountains = UIImageView(image: Asset.Images.mountains.image)

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

        configureNavigationBar()
        configureBackground()
        configureImageLogo()
        createAuthorizationButton()
        createTitleLabel()

        setupConstraints()
    }

    private func configureNavigationBar() {
        guard let navigationController = self.navigationController else { return }
        navigationController.navigationBar.tintColor = Asset.Colors.backButtonTextColor.color
        navigationController.navigationBar.isTranslucent = true
    }

    private func configureBackground() {
        let backgroundView = BackgroundGradientView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        view.addSubview(backgroundView)

        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(imageMountains)
    }

    private func configureImageLogo() {
        view.addSubview(imageLogo)
        imageLogo.alpha = 0.5
        imageLogo.contentMode = .scaleAspectFill
    }

    private func createTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = Fonts.SFProDisplay.semibold.font(size: 24.0)
        titleLabel.text = Strings.appName.uppercased()
        titleLabel.textAlignment = .center
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).inset(42)
            make.centerX.equalTo(safeArea)
        }

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
