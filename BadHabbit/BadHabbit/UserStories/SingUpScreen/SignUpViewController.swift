//
//  SignUpViewController.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 19/07/2023.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    private var backgroundImageView: UIImageView!
    private var welcomeLabel: UILabel!
    private var appNameLabel: UILabel!
    private var logoImageView: UIImageView!
    private var logoLabel: UILabel!
    private var phraseLabel: UILabel!
    private var startButton: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension SignUpViewController {
    private func setupUI() {
        view.backgroundColor = UIColor(hexNumber: 0xCFCFCF)
        
        configureBackgroundImageView()
        configureWelcomLabel()
        configureAppNameLabel()
        configureLogoImageView()
        configurePhraseLabel()
        configureStartButton()
        
        addSubviews([backgroundImageView,
                     welcomeLabel,
                     appNameLabel,
                     logoImageView,
                     phraseLabel,
                     startButton
                    ],
                    toSuperview: view)
        
        setupViewConstraints()
    }
    
    private func addSubviews(_ views: [UIView], toSuperview superview: UIView) {
        views.forEach { subview in
            superview.addSubview(subview)
        }
    }
    
    private func configureBackgroundImageView() {
        backgroundImageView = UIImageView(image: UIImage(named: "mountains"))
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureWelcomLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineHeightMultiple = 1.3

        let attributes: [NSAttributedString.Key: Any] = [
             .kern: -0.41,
             .font: UIFont(name: FontName.SFProDisplayMedium.rawValue, size: 16.0)!,
             .foregroundColor: UIColor(hexNumber: 0x000000),
             .paragraphStyle: paragraphStyle
        ]
        
        label.attributedText = NSAttributedString(string: "ДОБРО ПОЖАЛОВАТЬ В", attributes: attributes)

        welcomeLabel = label
    }
    
    private func configureAppNameLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineHeightMultiple = 1.3

        let stringAttributes: [NSAttributedString.Key: Any] = [
             .kern: -0.41,
             .font: UIFont(name: FontName.SFProDisplayBold.rawValue, size: 24.0)!,
             .foregroundColor: UIColor.black,
             .paragraphStyle: paragraphStyle
        ]
        
        label.attributedText = NSAttributedString(string: "HABIT HERO", attributes: stringAttributes)

        appNameLabel = label
    }
    
    private func configureLogoImageView() {
        logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        configureLogoLabel()
        logoImageView.addSubview(logoLabel)
    }
    
    private func configureLogoLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left

        let attributes: [NSAttributedString.Key: Any] = [
             .kern: -0.41,
             .font: UIFont(name: FontName.interExtraBold.rawValue, size: 15.0)!,
             .foregroundColor: UIColor(hexNumber: 0xFFFFFF),
             .paragraphStyle: paragraphStyle
        ]
        
        label.attributedText = NSAttributedString(string: "ЛОГО", attributes: attributes)
        
        logoLabel = label
    }
    
    private func configurePhraseLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineHeightMultiple = 1.5
        paragraphStyle.lineBreakMode = .byWordWrapping

        let attributes: [NSAttributedString.Key: Any] = [
             .kern: -0.41,
             .font: UIFont(name: FontName.SFProDisplayMedium.rawValue, size: 14.0)!,
             .foregroundColor: UIColor.black,
             .paragraphStyle: paragraphStyle
        ]
        
        let phrase =
"""
НЕ ЗАПОЛНЯЮТ ПУСТОТУ,  ОНИ ЕЕ СОЗДАЮТ!
НЕ ЗАПОЛНЯЮТ ПУСТОТУ,  ОНИ ЕЕ СОЗДАЮТ!
тут какая-то фраза
"""
        
        label.attributedText = NSAttributedString(string: phrase, attributes: attributes)
        label.numberOfLines = 0

        phraseLabel = label
    }
    
    private func configureStartButton() {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = "НАЧАТЬ"
        buttonConfiguration.cornerStyle = .large
        buttonConfiguration.baseBackgroundColor = UIColor(hexNumber: 0x090909)
        
        let button = UIButton(configuration: buttonConfiguration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        startButton = button
    }
    
    @objc
    private func startButtonTapped() {
    }
    
    private func setupViewConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        backgroundImageView.snp.makeConstraints { make in
            let heightMultiplier: CGFloat = 445 / 844

            make.height.equalToSuperview().multipliedBy(heightMultiplier)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(safeArea)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).inset(20)
            make.centerX.equalTo(safeArea)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom)
            make.centerX.equalTo(safeArea)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(safeArea)
        }
        
        logoLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(safeArea)
        }
        
        phraseLabel.snp.makeConstraints { make in
            make.bottom.equalTo(startButton.snp.top).inset(-30)
            make.leading.trailing.equalTo(safeArea).inset(16)
            make.centerX.equalTo(safeArea)
        }
        
        startButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalTo(safeArea).inset(16)
            make.bottom.equalTo(safeArea.snp.bottom).inset(20)
        }
    }
}
