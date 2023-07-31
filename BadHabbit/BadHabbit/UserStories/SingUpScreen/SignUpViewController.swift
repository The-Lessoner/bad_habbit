//
//  SignUpViewController.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 19/07/2023.
//

import UIKit
import SnapKit

protocol SignUpViewProtocol: AnyObject { }

final class SignUpViewController: BaseViewController, SignUpViewProtocol {
    private lazy var backgroundImageView = UIImageView()
    private lazy var welcomeLabel = UILabel()
    private lazy var appNameLabel = UILabel()
    private lazy var logoImageView = UIImageView()
    private lazy var logoLabel = UILabel()
    private lazy var phraseLabel = UILabel()
    
    lazy var startButton = UIButton()
    
    private let presenter: SignUpScreenPresenterProtocol
    
    init(presenter: SignUpScreenPresenterProtocol) {
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
        view.backgroundColor = UIColor.darkBackground
        
        view.addSubview(backgroundImageView)
        backgroundImageView.image = UIImage(named: "mountains")
    }
    
    private func addWelcomeLabel() {
        view.addSubview(welcomeLabel)
        
        welcomeLabel.text = String(localized: "signUpScreen.welcomeLabelText").uppercased()
        welcomeLabel.font = UIFont(name: FontName.SFProDisplayMedium.rawValue, size: 16.0)
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = .black
    }
    
    private func addAppNameLabel() {
        view.addSubview(appNameLabel)

        appNameLabel.text = String(localized: "appName").uppercased()
        appNameLabel.font = UIFont(name: FontName.SFProDisplayBold.rawValue, size: 24.0)
        appNameLabel.textAlignment = .center
        appNameLabel.textColor = .black
    }
    
    private func addLogoImageView() {
        view.addSubview(logoImageView)
        addLogoLabel()
        
        logoImageView.image = UIImage(named: "logo")
        logoImageView.alpha = 0.5
    }
    
    private func addLogoLabel() {
        logoImageView.addSubview(logoLabel)
        
        logoLabel.text = String(localized: "signUpScreen.logoLabelText").uppercased()
        logoLabel.font = UIFont(name: FontName.interExtraBold.rawValue, size: 15.0)
        logoLabel.textAlignment = .left
        logoLabel.textColor = UIColor(hexNumber: 0xFFFFFF)
    }
    
    private func addPhraseLabel() {
        view.addSubview(phraseLabel)
        
        phraseLabel.text = String(localized: "signUpScreen.phraseLabelText").uppercased()
        phraseLabel.font = UIFont(name: FontName.SFProDisplayMedium.rawValue, size: 14.0)
        phraseLabel.textAlignment = .center
        phraseLabel.textColor = .black
        phraseLabel.lineBreakMode = .byWordWrapping
        phraseLabel.numberOfLines = 0
    }
    
    private func addStartButton() {
        view.addSubview(startButton)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = String(localized: "signUpScreen.startButtonTitle").uppercased()
        buttonConfiguration.cornerStyle = .large
        buttonConfiguration.baseBackgroundColor = UIColor(hexNumber: 0x090909)

        startButton.configuration = buttonConfiguration
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    private func setupViewConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        backgroundImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(LayoutConstants.BackgroundImage.heightMultiplier)
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
        
        safeArea.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView).offset(35)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.size.equalTo(safeArea.snp.width).multipliedBy(LayoutConstants.LogoImageView.sizeMultiplier)
        }
        
        logoLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(logoImageView)
        }
        
        phraseLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeArea).inset(LayoutConstants.leadingInset)
            make.centerX.equalTo(safeArea)
        }
        
        startButton.snp.makeConstraints { make in
            make.height.equalTo(LayoutConstants.ActionButton.height)
            make.leading.equalTo(safeArea).inset(LayoutConstants.leadingInset)
            make.trailing.equalTo(safeArea).inset(LayoutConstants.trailingInset)
            make.bottom.equalTo(safeArea.snp.bottom).inset(LayoutConstants.ActionButton.bottomInset)
            make.top.equalTo(phraseLabel.snp.bottom).offset(30)
        }
    }
    
    @objc
    private func startButtonTapped() {
        presenter.startButtonTapped()
    }
}
