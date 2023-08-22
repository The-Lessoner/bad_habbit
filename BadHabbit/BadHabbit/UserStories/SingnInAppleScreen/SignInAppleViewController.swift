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
    //    private let backButton: UIButton = {
    //        let button = UIButton()
    //        button.setTitle(String(localized: "backButtonText"), for: .normal)
    //        button.setTitleColor(UIColor(named: "backButtonTextColor"), for: .normal)
    //        return button
    //    }()

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
        view.backgroundColor = Asset.Colors.background.color
        imageMountains = createImageView(image: Asset.Images.mountains.image)
        imageLogo = createImageView(image: Asset.Images.logo.image)
        imageLogo.alpha = 0.5
        imageLogo.contentMode = .scaleAspectFill
        createAuthorizationButton()
        setupConstraints()
    }

    func setupNavBar() {
        navigationItem.title = String(localized: "appName")
        let barButtonImage = UIImage(systemName: "chevron.left")
        let barButtonTitle = String(localized: "backButtonText")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: barButtonTitle, style: .plain, target: self, action: #selector(backAction)
        )

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.35)
        appearance.titleTextAttributes = [
            .font: UIFont(name: FontName.SFProDisplaySemibold.rawValue, size: 17)!,
            .foregroundColor: UIColor.black
        ]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor(named: "backButtonTextColor")

    }

    @objc func backAction() {
        navigationController?.pushViewController(EmptyScreenAssembly().assembleStory(), animated: true)
    }

    private func createImageView(name: String) -> UIImageView {
        let imageName = name
        let image = UIImage(named: imageName)
    private func createImageView(image: UIImage) -> UIImageView {
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
