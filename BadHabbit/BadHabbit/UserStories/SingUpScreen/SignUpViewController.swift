//
//  SignUpViewController.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 19/07/2023.
//

import UIKit
import SnapKit

protocol SignUpViewProtocol: AnyObject {
    func updateStartButton(isEnabled: Bool)
    func updatePageControlPage(toPage page: Int)
    func updateCollectionView(toPage page: Int)
}

final class SignUpViewController: BaseViewController, SignUpViewProtocol {
    private lazy var backgroundImageView = UIImageView()
    private lazy var welcomeLabel = UILabel()
    private lazy var appNameLabel = UILabel()
    private lazy var slidesCollectoinView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
        addSlidesCollectoinView()
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
    
    private func addSlidesCollectoinView() {
        view.addSubview(slidesCollectoinView)
        
        slidesCollectoinView.backgroundColor = .none
        slidesCollectoinView.isPagingEnabled = true
        slidesCollectoinView.showsHorizontalScrollIndicator = false
        
        slidesCollectoinView.register(SignUpScreenCollectionViewCell.self, forCellWithReuseIdentifier: SignUpScreenCollectionViewCell.identifier)
        slidesCollectoinView.dataSource = self
        slidesCollectoinView.delegate = self
        
        if let layout = slidesCollectoinView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = LayoutConstants.ImageLogo.widht
            
            let slidesEdgesInset = view.bounds.width / 2 - LayoutConstants.ImageLogo.widht / 2
            layout.sectionInset = UIEdgeInsets(top: 0, left: slidesEdgesInset, bottom: 0, right: slidesEdgesInset)
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
        pageControl.numberOfPages = presenter.images.count
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
        
        slidesCollectoinView.snp.makeConstraints { make in
            make.leading.equalTo(safeArea.snp.leading)
            make.trailing.equalTo(safeArea.snp.trailing)
            make.centerY.equalTo(safeArea)
            make.height.equalTo(LayoutConstants.ImageLogo.height)
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
    private func pageControlPageChanged(sender: UIPageControl) {
        presenter.pageControlPageChanged(toPage: sender.currentPage)
    }
    
    @objc
    private func startButtonTapped() {
        presenter.startButtonTapped()
    }
}

extension SignUpViewController {
    func updateStartButton(isEnabled: Bool) {
        startButton.isEnabled = isEnabled
    }
    
    func updatePageControlPage(toPage page: Int) {
        pageControl.currentPage = page
    }
    
    func updateCollectionView(toPage page: Int) {
        let offset = pageControl.currentPage * Int(view.bounds.width)
        slidesCollectoinView.setContentOffset(
            CGPoint(x: offset, y: 0),
            animated: true
        )
    }
}

extension SignUpViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignUpScreenCollectionViewCell.identifier, for: indexPath)
        
        guard let cell = cell as? SignUpScreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.imageView.image = presenter.images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: LayoutConstants.ImageLogo.widht, height: LayoutConstants.ImageLogo.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.collectionViewSwiped(toItemAt: indexPath.row)
    }
}
