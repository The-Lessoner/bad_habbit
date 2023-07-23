//
//  SignUpViewController.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 19/07/2023.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    private lazy var backgroundImageView = UIImageView()
    private lazy var welcomeLabel = UILabel()
    private lazy var appNameLabel = UILabel()
    private lazy var logoImageView = UIImageView()
    private lazy var logoLabel = UILabel()
    private lazy var phraseLabel = UILabel()
    private lazy var startButton = UIButton()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension SignUpViewController {
    private func setupUI() {
        configureBackground()
        
        addWelcomeLabel()
        addAppNameLabel()
        addLogoImageView()
        addPhraseLabel()
        addStartButton()
        
        setupViewConstraints()
    }
    
    private func configureBackground() {
        view.backgroundColor = UIColor(hexNumber: 0xCFCFCF)
        
        view.addSubview(backgroundImageView)
        backgroundImageView.image = UIImage(named: "mountains")
    }
    
    private func addWelcomeLabel() {
        view.addSubview(welcomeLabel)
        
        welcomeLabel.text = String(localized: "welcomeLabelText").uppercased()
        welcomeLabel.font = UIFont(name: FontName.SFProDisplayMedium.rawValue, size: 16.0)
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = .black
    }
    
    private func addAppNameLabel() {
        view.addSubview(appNameLabel)

        appNameLabel.text = "HABIT HERO".uppercased()
        appNameLabel.font = UIFont(name: FontName.SFProDisplayBold.rawValue, size: 24.0)
        appNameLabel.textAlignment = .center
        appNameLabel.textColor = .black
    }
    
    private func addLogoImageView() {
        view.addSubview(logoImageView)
        addLogoLabel()
        
        logoImageView.image = UIImage(named: "logo")
    }
    
    private func addLogoLabel() {
        logoImageView.addSubview(logoLabel)
        
        logoLabel.text = String(localized: "logoLabelText").uppercased()
        logoLabel.font = UIFont(name: FontName.interExtraBold.rawValue, size: 15.0)
        logoLabel.textAlignment = .left
        logoLabel.textColor = UIColor(hexNumber: 0xFFFFFF)
    }
    
    private func addPhraseLabel() {
        view.addSubview(phraseLabel)
        
        phraseLabel.text = String(localized: "phraseLabelText").uppercased()
        phraseLabel.font = UIFont(name: FontName.SFProDisplayMedium.rawValue, size: 14.0)
        phraseLabel.textAlignment = .center
        phraseLabel.textColor = .black
        phraseLabel.lineBreakMode = .byWordWrapping
        phraseLabel.numberOfLines = 0
    }
    
    private func addStartButton() {
        view.addSubview(startButton)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = String(localized: "startButtonTitle").uppercased()
        buttonConfiguration.cornerStyle = .large
        buttonConfiguration.baseBackgroundColor = UIColor(hexNumber: 0x090909)

        startButton.configuration = buttonConfiguration
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
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
            make.top.equalTo(safeArea).inset(35)
            make.centerX.equalTo(safeArea)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom)
            make.centerX.equalTo(safeArea)
        }
        
        logoImageView.snp.makeConstraints { make in
            let multiplayer: CGFloat = 196 / 390
            
            make.centerX.equalTo(safeArea)
            make.centerY.equalTo(safeArea).offset(-35)
            make.size.equalTo(safeArea.snp.width).multipliedBy(multiplayer)
        }
        
        logoLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(logoImageView)
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
