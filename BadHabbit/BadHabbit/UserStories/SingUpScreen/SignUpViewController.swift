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
        if let layout = slidesCollectoinView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        slidesCollectoinView.register(SignUpScreenCollectionViewCell.self, forCellWithReuseIdentifier: SignUpScreenCollectionViewCell.identifier)
        slidesCollectoinView.dataSource = self
        slidesCollectoinView.delegate = self
    }
    
    private func addPhraseLabel() {
        view.addSubview(phraseLabel)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = Multipliers.phraseLabelLineHeight
        let attributes: [NSAttributedString.Key: Any] = [.paragraphStyle: paragraphStyle]
        
        phraseLabel.attributedText = NSAttributedString(string: Strings.SignUpScreen.phraseLabelText.uppercased(), attributes: attributes)
        
        phraseLabel.font = Fonts.SFProDisplay.medium.font(size: 14.0)
        phraseLabel.textAlignment = .center
        phraseLabel.textColor = .black
        phraseLabel.lineBreakMode = .byWordWrapping
        phraseLabel.numberOfLines = 0
    }
    
    private func addPageControl() {
        view.addSubview(pageControl)
        pageControl.numberOfPages = presenter.numberOfItems
        pageControl.pageIndicatorTintColor = Assets.Colors.darkBlue.color
        pageControl.currentPageIndicatorTintColor = Assets.Colors.purpleLight.color
        pageControl.direction = .leftToRight
        pageControl.backgroundStyle = .minimal
        pageControl.preferredCurrentPageIndicatorImage = UIImage(systemName: "circle.fill")
        
        pageControl.addTarget(self, action: #selector(pageControlPageChanged), for: .valueChanged)
    }
    
    private func addStartButton() {
        view.addSubview(startButton)
        
        startButton.layer.cornerRadius = Radius.actionButtonCorner
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
            make.centerY.equalTo(backgroundImageView.snp.top)
            make.height.equalTo(LayoutConstants.ImageLogo.size)
            
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.bottom.equalTo(phraseLabel.snp.bottom).inset(93)
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
            make.top.equalTo(phraseLabel.snp.bottom).offset(LayoutConstants.ActionButton.topOffset)
        }
    }
    
    private func updateStartButton(isEnabled: Bool) {
        if isEnabled {
            startButton.isEnabled = isEnabled
        }
    }
    
    @objc
    private func pageControlPageChanged(sender: UIPageControl) {
        slidesCollectoinView.scrollToItem(
            at: IndexPath(row: sender.currentPage, section: 0),
            at: .centeredHorizontally,
            animated: true)
        updateStartButton(isEnabled: sender.currentPage == 2)
    }
    
    @objc
    private func startButtonTapped() {
        presenter.startButtonTapped()
    }
}

extension SignUpViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignUpScreenCollectionViewCell.identifier, for: indexPath)
        
        guard let cell = cell as? SignUpScreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.imageView.image = presenter.image(forRow: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
        updateStartButton(isEnabled: indexPath.row == 2)
    }
}

extension SignUpViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        LayoutConstants.CollectionView.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        LayoutConstants.CollectionView.minimumLineSpacing(inSuperviewWidth: view.bounds.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let sideInset = LayoutConstants.CollectionView.sideInset(toSuperviewWidth: view.bounds.width)
        return UIEdgeInsets(
            top: LayoutConstants.CollectionView.topInset,
            left: sideInset,
            bottom: LayoutConstants.CollectionView.bottomInset,
            right: sideInset
        )
    }
}
