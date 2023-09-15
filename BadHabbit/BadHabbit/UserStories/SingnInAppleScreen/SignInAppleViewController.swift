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
    private lazy var authorizationButton = UIButton()
    private lazy var titleLabel = UILabel()
    private lazy var imageLogo = UIImageView(image: Assets.Images.logo.image)
    private lazy var imageMountains = UIImageView(image: Assets.Images.mountains.image)
    private lazy var backgroundView = BackgroundGradientView()

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
    override func loadView() {
        view = BackgroundGradientView(frame: UIScreen.main.bounds)
    }

    private func setupUI() {

        setupConstraints()

        configureNavigationBar()
        configureImageLogo()
        configureAuthorizationButton()
        configureTitleLabel()
    }

    private func configureNavigationBar() {
        guard let navigationController = self.navigationController else { return }
        navigationController.navigationBar.tintColor = Assets.Colors.purpleLight.color
        navigationController.navigationBar.isTranslucent = true
    }

    private func configureImageLogo() {
        imageLogo.alpha = 0.5
        imageLogo.contentMode = .scaleAspectFill
    }

    private func configureTitleLabel() {
        titleLabel.textColor = .black
        titleLabel.font = Fonts.SFProDisplay.semibold.font(size: 24.0)
        titleLabel.text = Strings.appName.uppercased()
        titleLabel.textAlignment = .center
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).inset(42)
            make.centerX.equalTo(safeArea)
        }

        view.addSubview(imageMountains)
        imageMountains.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.bottom.leading.trailing.equalToSuperview()
        }

        view.addSubview(imageLogo)
        imageLogo.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.centerY.equalTo(imageMountains.snp.top)
            make.size.equalTo(LayoutConstants.ImageLogo.size)
        }

        view.addSubview(authorizationButton)
        authorizationButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea).inset(LayoutConstants.ActionButton.bottomInset)
            make.height.equalTo(LayoutConstants.ActionButton.height)
            make.leading.trailing.equalTo(safeArea).inset(LayoutConstants.trailingInset)
        }
    }

    private func configureAuthorizationButton() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .black
        config.image = UIImage(systemName: "apple.logo")
        config.imagePadding = 5
        let title = Strings.SignInAppleScreen.authorizationButtonTitle.uppercased()
        let attibutes = AttributeContainer([.font: Fonts.SFProDisplay.medium.font(size: 17)])
        config.attributedTitle = AttributedString(title, attributes: attibutes)
        authorizationButton.configuration = config
        authorizationButton.layer.cornerRadius = 12.0
        authorizationButton.layer.masksToBounds = true

        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }

    @objc
    private func handleAuthorizationAppleIDButtonPress() {
        presenter.authorizationButtonDidTap()
    }

}
