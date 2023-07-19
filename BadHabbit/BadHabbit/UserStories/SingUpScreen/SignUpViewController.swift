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

        let attributes: [NSAttributedString.Key: Any] = [
             .kern: 0.41,
             .font: UIFont(name: FontName.SFProDisplayMedium.rawValue, size: 16.0)!]
        let text = NSAttributedString(string: "ДОБРО ПОЖАЛОВАТЬ В", attributes: attributes)
        label.attributedText = text
        label.textAlignment = .center
        label.textColor = UIColor(hexNumber: 0x000000)

        welcomeLabel = label
    }
    
    private func configureAppNameLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        let attributes: [NSAttributedString.Key: Any] = [
             .kern: 0.41,
             .font: UIFont(name: FontName.SFProDisplayBold.rawValue, size: 24.0)!]
        let text = NSAttributedString(string: "HABIT HERO", attributes: attributes)
        label.attributedText = text
        label.textAlignment = .center
        label.textColor = .black

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

        let attributes: [NSAttributedString.Key: Any] = [
             .kern: 0.41,
             .font: UIFont(name: FontName.interExtraBold.rawValue, size: 15.0)!]
        let text = NSAttributedString(string: "ЛОГО", attributes: attributes)
        label.attributedText = text
        label.textAlignment = .left
        label.textColor = UIColor(hexNumber: 0xFFFFFF)

        logoLabel = label
    }
    
    private func configurePhraseLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        let attributes: [NSAttributedString.Key: Any] = [
             .kern: 0.41,
             .font: UIFont(name: FontName.SFProDisplayMedium.rawValue, size: 14.0)!]
        let phrase =
"""
НЕ ЗАПОЛНЯЮТ ПУСТОТУ,  ОНИ ЕЕ СОЗДАЮТ!
НЕ ЗАПОЛНЯЮТ ПУСТОТУ,  ОНИ ЕЕ СОЗДАЮТ!
тут какая-то фраза
"""
        
        let text = NSAttributedString(string: phrase, attributes: attributes)
        label.attributedText = text
        label.textAlignment = .center
        label.textColor = UIColor(hexNumber: 0x000000)
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
            let heightMultiplayer: CGFloat = 445/844

            make.height.equalToSuperview().multipliedBy(heightMultiplayer)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(safeArea)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(82)
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
            make.top.equalTo(backgroundImageView.snp.bottom).inset(248)
            make.leading.trailing.equalTo(safeArea).inset(16)
            make.centerX.equalTo(safeArea)
        }
        
        startButton.snp.makeConstraints { make in
            let heightMultiplayer: CGFloat = 50/844

            make.height.equalToSuperview().multipliedBy(heightMultiplayer)
            make.leading.trailing.equalTo(safeArea).inset(16)
            make.centerX.equalTo(safeArea)
            make.bottom.equalTo(safeArea).inset(20)
        }
    }
}
