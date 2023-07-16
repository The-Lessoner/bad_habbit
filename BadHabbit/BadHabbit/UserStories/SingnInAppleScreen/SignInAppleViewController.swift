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
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.26
        titleLabel.attributedText = NSMutableAttributedString(string: "habit hero", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.text = titleLabel.text?.uppercased()
        titleLabel.textAlignment = .center
        setupTitleLabelConstraints()

    }

    private func setupTitleLabelConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(82)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func setupImageLogoConstraints() {
        imageLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-35)
            $0.size.equalTo(196)
        }
    }

    private func setupImageMountainsConstraints() {
        imageMountains.snp.makeConstraints {
            $0.top.equalToSuperview().inset(399)
            $0.bottom.leading.trailing.equalToSuperview()
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
        authorizationButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(54)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    @objc
    func handleAuthorizationAppleIDButtonPress() {
    }
}
