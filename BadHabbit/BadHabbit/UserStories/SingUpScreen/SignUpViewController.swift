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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
        view.backgroundColor = Asset.Colors.background.color
        
        view.addSubview(backgroundImageView)
        backgroundImageView.image = Asset.Images.mountains.image
    }
    
    private func addWelcomeLabel() {
        view.addSubview(welcomeLabel)
        
        welcomeLabel.text = Strings.SignUpScreen.welcomeLabelText.uppercased()
        welcomeLabel.font = Fonts.SFProDisplay.medium.font(size: 16.0)
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = .black
    }
    
    private func addAppNameLabel() {
        view.addSubview(appNameLabel)

        appNameLabel.text = Strings.appName.uppercased()
        appNameLabel.font = Fonts.SFProDisplay.bold.font(size: 24.0)
        appNameLabel.textAlignment = .center
        appNameLabel.textColor = .black
    }
    
    private func addLogoImageView() {
        view.addSubview(logoImageView)
        addLogoLabel()
        
        logoImageView.image = Asset.Images.logo.image
        logoImageView.alpha = 0.5
        logoImageView.contentMode = .scaleAspectFill
    }
    
    private func addLogoLabel() {
        logoImageView.addSubview(logoLabel)
        
        logoLabel.text = Strings.SignUpScreen.logoLabelText.uppercased()
        logoLabel.font = Fonts.Inter.extraBold.font(size: 15.0)
        logoLabel.textAlignment = .left
        logoLabel.textColor = Asset.Colors.logoLabelText.color
    }
    
    private func addPhraseLabel() {
        view.addSubview(phraseLabel)
        
        phraseLabel.text = Strings.SignUpScreen.phraseLabelText.uppercased()
        phraseLabel.font = Fonts.SFProDisplay.medium.font(size: 14.0)
        phraseLabel.textAlignment = .center
        phraseLabel.textColor = .black
        phraseLabel.lineBreakMode = .byWordWrapping
        phraseLabel.numberOfLines = 0
    }
    
    private func addStartButton() {
        view.addSubview(startButton)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = Strings.SignUpScreen.startButtonTitle.uppercased()
        buttonConfiguration.cornerStyle = .large
        buttonConfiguration.baseBackgroundColor = Asset.Colors.startButtonBaseBackground.color

        startButton.configuration = buttonConfiguration
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    private func setupViewConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.leading.trailing.bottom.equalToSuperview()
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
            make.size.equalTo(196)
            make.centerX.equalTo(safeArea)
            make.centerY.equalTo(backgroundImageView.snp.top)
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
