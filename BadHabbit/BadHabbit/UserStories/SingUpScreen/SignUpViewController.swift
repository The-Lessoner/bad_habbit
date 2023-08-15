//
//  SignUpViewController.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 19/07/2023.
//

import UIKit
import SnapKit

protocol SignUpViewProtocol: AnyObject {
    func updateLogoImageViewImage(_ image: UIImage?)
    func updateStartButtonEnabledState(_ isEnabled: Bool)
    func updateStartButtonBackgroundColor(_ color: UIColor?)
    func updatePageControlPage(toPage page: Int)
}

final class SignUpViewController: BaseViewController, SignUpViewProtocol {
    private lazy var backgroundImageView = UIImageView()
    private lazy var welcomeLabel = UILabel()
    private lazy var appNameLabel = UILabel()
    private lazy var logoImageView = UIImageView()
    private lazy var phraseLabel = UILabel()
    private lazy var pageControl = UIPageControl()
    
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
        addPageControl()
        addStartButton()
        
        setupViewConstraints()
    }
    
    private func configureBackground() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        
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
        addSwipeGestureRecognizers(
            recognizers: [SwipeGestureRecognizer.left, SwipeGestureRecognizer.right],
            action: #selector(logoImageViewSwiped),
            toView: logoImageView
        )
        
        logoImageView.image = UIImage(named: "signUpScreenLogo")
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.isUserInteractionEnabled = true
    }
    
    private func addSwipeGestureRecognizers(recognizers: [UIGestureRecognizer], action: Selector, toView: UIView) {
        recognizers.forEach { recognizer in
            recognizer.addTarget(self, action: action)
            view.addGestureRecognizer(recognizer)
        }
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
    
    private func addPageControl() {
        view.addSubview(pageControl)
        
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = UIColor(named: "darkBlueColor")
        pageControl.currentPageIndicatorTintColor = UIColor(named: "pirpleLightColor")
        pageControl.direction = .leftToRight
        pageControl.backgroundStyle = .minimal
        
        pageControl.addTarget(self, action: #selector(pageControlPageChanged), for: .valueChanged)
    }
    
    private func addStartButton() {
        view.addSubview(startButton)
        
        startButton.layer.cornerRadius = 12
        startButton.isEnabled = false
        
        startButton.setTitle(
            String(localized: "signUpScreen.startButtonTitle").uppercased(),
            for: .normal
        )
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitleColor(.black, for: .disabled)
        startButton.backgroundColor = UIColor(named: "startButtonUnenabledBackgroundColor")
        
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
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.bottom.equalTo(phraseLabel.snp.top).inset(-30)
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
    private func logoImageViewSwiped(gestureRecognizer: UISwipeGestureRecognizer) {
        presenter.logoImageViewSwiped(gestureRecognizer.direction, currentPageControlPage: pageControl.currentPage)
        presenter.pageControlPageChanged(toPage: pageControl.currentPage)
    }
    
    @objc
    private func pageControlPageChanged(pageControl: UIPageControl) {
        presenter.pageControlPageChanged(toPage: pageControl.currentPage)
    }
    
    @objc
    private func startButtonTapped() {
        presenter.startButtonTapped()
    }
}

extension SignUpViewController {
    func updateLogoImageViewImage(_ image: UIImage?) {
        logoImageView.image = image
    }
    
    func updateStartButtonEnabledState(_ isEnabled: Bool) {
        startButton.isEnabled = isEnabled
    }
    
    func updateStartButtonBackgroundColor(_ color: UIColor?) {
        startButton.backgroundColor = color
    }
    
    func updatePageControlPage(toPage page: Int) {
        pageControl.currentPage = page
    }
}
