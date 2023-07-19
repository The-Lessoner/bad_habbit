//
//  SignInAppleViewController.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 14.07.23.
//

import UIKit
import SnapKit
import AuthenticationServices

class SignInAppleViewController: UIViewController {
    private var authorizationButton: ASAuthorizationAppleIDButton!
    private var imageLogo: UIImageView!
    private var imageMountains: UIImageView!
    private var titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension SignInAppleViewController {

    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1.00)
        imageMountains = createImageView(name: "mountains")
        setupImageMountainsConstraints()
        imageLogo = createImageView(name: "logo")
        setupImageLogoConstraints()
        createAuthorizationButton()
        createTitleLabel()
    }

    private func createImageView(name: String) -> UIImageView {
        let imageName = name
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)

        return imageView
    }

    private func createTitleLabel() {
        titleLabel.frame = CGRect(x: 0, y: 0, width: 358, height: 36)
        view.addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.26
        let quote = "habit hero"
        let attributes: [NSAttributedString.Key: Any]  = [ 
            .kern: -0.41,
            .paragraphStyle: paragraphStyle
        ]
        titleLabel.attributedText = NSMutableAttributedString(string: quote, attributes: attributes)
        titleLabel.text = titleLabel.text?.uppercased()
        titleLabel.textAlignment = .center
        setupTitleLabelConstraints()

    }

    private func setupTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(82)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func setupImageLogoConstraints() {
        imageLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-35)
            make.size.equalTo(196)
        }
    }

    private func setupImageMountainsConstraints() {
        imageMountains.snp.makeConstraints { make in
            let multiplier: CGFloat = 445/844
            make.height.equalToSuperview().multipliedBy(multiplier)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }

    private func createAuthorizationButton() {
        authorizationButton = ASAuthorizationAppleIDButton()
        view.addSubview(authorizationButton)
        authorizationButton.layer.cornerRadius = 12
        setupAuthorizationButtonConstraints()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }

    private func setupAuthorizationButtonConstraints() {
        authorizationButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(54)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    @objc
    func handleAuthorizationAppleIDButtonPress() {
    }
}
