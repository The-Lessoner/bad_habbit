//
//  SignInAppleViewController.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 14.07.23.
//

import UIKit
import SnapKit
import AuthenticationServices

final class SignInAppleViewController: UIViewController {
    private lazy var authorizationButton = ASAuthorizationAppleIDButton()
    private lazy var titleLabel = UILabel()
    private lazy var imageLogo = UIImageView()
    private lazy var imageMountains = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension SignInAppleViewController {

    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1.00)
        imageMountains = createImageView(name: "mountains")
        imageLogo = createImageView(name: "logo")
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
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.26
        let attributes: [NSAttributedString.Key: Any]  = [
            .kern: -0.41,
            .paragraphStyle: paragraphStyle
        ]
        titleLabel.attributedText = NSMutableAttributedString(string: appTitle, attributes: attributes)
        titleLabel.text = titleLabel.text?.uppercased()
        titleLabel.textAlignment = .center
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).inset(TitleLabelConstraints.top)
            make.leading.trailing.equalToSuperview().inset(TitleLabelConstraints.leading)
        }

        imageLogo.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.centerY.equalTo(safeArea).offset(-35)
            make.size.equalTo(196)
        }

        imageMountains.snp.makeConstraints { make in
            let multiplier: CGFloat = 445/844
            make.height.equalToSuperview().multipliedBy(multiplier)
            make.bottom.leading.trailing.equalToSuperview()
        }

        authorizationButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea).inset(ButtonConstraints.bottom)
            make.height.equalTo(ButtonConstraints.eight)
            make.leading.trailing.equalTo(safeArea).inset(ButtonConstraints.leading)
        }
    }

    private func createAuthorizationButton() {
        view.addSubview(authorizationButton)
        authorizationButton.layer.cornerRadius = buttonCornerRadius
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }

    @objc
    func handleAuthorizationAppleIDButtonPress() {
    }
}
