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
    func updateStartButton(isEnabled: Bool)
    func updatePageControlPage(toPage page: Int)
}

final class SignUpViewController: BaseViewController, SignUpViewProtocol {
    private lazy var backgroundImageView = UIImageView()
    private lazy var welcomeLabel = UILabel()
    private lazy var appNameLabel = UILabel()
    private lazy var logoImageView = UIImageView()
    private lazy var phraseLabel = UILabel()
    private lazy var pageControl = UIPageControl()
    
    lazy var startButton = GradientButton()
    
    private let presenter: SignUpScreenPresenterProtocol
    
    init(presenter: SignUpScreenPresenterProtocol) {
        self.presenter = presenter
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = BackgroundGradientView(frame: UIScreen.main.bounds)
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
        view.addSubview(backgroundImageView)
        backgroundImageView.image = Assets.Images.mountains.image
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
        addSwipeGestureRecognizers(
            recognizers: [SwipeGestureRecognizer.left, SwipeGestureRecognizer.right],
            action: #selector(logoImageViewSwiped),
            toView: logoImageView
        )
        
        logoImageView.image = Assets.Images.signUpScreenLogo.image
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
        
        phraseLabel.text = Strings.SignUpScreen.phraseLabelText.uppercased()
        phraseLabel.font = Fonts.SFProDisplay.medium.font(size: 14.0)
        phraseLabel.textAlignment = .center
        phraseLabel.textColor = .black
        phraseLabel.lineBreakMode = .byWordWrapping
        phraseLabel.numberOfLines = 0
    }
    
    private func addPageControl() {
        view.addSubview(pageControl)
        
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = Assets.Colors.darkBlue.color
        pageControl.currentPageIndicatorTintColor = Assets.Colors.purpleLight.color
        pageControl.direction = .leftToRight
        pageControl.backgroundStyle = .minimal
        pageControl.preferredCurrentPageIndicatorImage = UIImage(systemName: "circle.fill")
        
        pageControl.addTarget(self, action: #selector(pageControlPageChanged), for: .valueChanged)
    }
    
    private func addStartButton() {
        view.addSubview(startButton)
        
        startButton.layer.cornerRadius = 12
        startButton.isEnabled = false
        
        startButton.setTitle(
            Strings.SignUpScreen.startButtonTitle.uppercased(),
            for: .normal
        )
        
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitleColor(.black, for: .disabled)
        startButton.titleLabel?.font = Fonts.SFProDisplay.medium.font(size: 17.0)
        startButton.titleLabel?.textAlignment = .left
        
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
    private func logoImageViewSwiped(_ gestureRecognizer: UISwipeGestureRecognizer) {
        presenter.logoImageViewSwiped(gestureRecognizer.direction, pageControlCurrentPage: pageControl.currentPage)
    }
    
    @objc
    private func pageControlPageChanged(sender: UIPageControl) {
        presenter.pageControlPageChanged(toPage: sender.currentPage)
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
    
    func updateStartButton(isEnabled: Bool) {
        startButton.isEnabled = isEnabled
    }
    
    func updatePageControlPage(toPage page: Int) {
        pageControl.currentPage = page
    }
}
