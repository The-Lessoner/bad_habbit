//
//  BreakHabitViewController.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 5.09.23.
//

import UIKit
import SnapKit

protocol BreakHabitViewProtocol: AnyObject { }

final class BreakHabitViewController: BaseViewController, BreakHabitViewProtocol {
    private lazy var titleLabel = UILabel()
    private lazy var phraseLabel = UILabel()
    private lazy var imageLogo = UIImageView(image: Asset.Images.logo.image)
    private lazy var imageMountains = UIImageView(image: Asset.Images.mountains.image)
    private lazy var backgroundView = BackgroundGradientView()
    private lazy var buttonGragientView = StartButtonGradientView()
    
    private lazy var startButton = UIButton()
    
    private let presenter: BreakHabitScreenPresenterProtocol
    
    init(presenter: BreakHabitScreenPresenterProtocol) {
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
}

extension BreakHabitViewController {
    
    private func setupUI() {
        
        setupConstraints()
        
        configureImageLogo()
        configureStartButton()
        configureTitleLabel()
        configurePhraseLabel()
    }
    
    private func configureImageLogo() {
        imageLogo.alpha = 0.5
        imageLogo.contentMode = .scaleAspectFill
    }
    
    private func configureTitleLabel() {
        titleLabel.textColor = .black
        titleLabel.font = Fonts.SFProDisplay.semibold.font(size: 24.0)
        titleLabel.text = Strings.appName.uppercased()
        titleLabel.textAlignment = .center
    }
    
    private func configurePhraseLabel() {
        phraseLabel.text = Strings.BreakHabitScreen.phraseLabelText.uppercased()
        phraseLabel.setLineSpacing(lineHeightMultiple: 1.26)
        phraseLabel.font = Fonts.SFProDisplay.medium.font(size: 14.0)
        phraseLabel.textAlignment = .center
        phraseLabel.textColor = .black
        phraseLabel.lineBreakMode = .byWordWrapping
        phraseLabel.numberOfLines = 0
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).inset(42)
            make.centerX.equalTo(safeArea)
        }
        
        view.addSubview(imageMountains)
        imageMountains.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(imageLogo)
        imageLogo.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.centerY.equalTo(imageMountains.snp.top)
            make.size.equalTo(LayoutConstants.ImageLogo.size)
        }
        
        view.addSubview(phraseLabel)
        phraseLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeArea).inset(LayoutConstants.leadingInset)
            make.centerX.equalTo(safeArea)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea).inset(LayoutConstants.ActionButton.bottomInset)
            make.height.equalTo(LayoutConstants.ActionButton.height)
            make.leading.trailing.equalTo(safeArea).inset(LayoutConstants.trailingInset)
            make.top.equalTo(phraseLabel.snp.bottom).offset(30)
        }
        
        startButton.addSubview(buttonGragientView)
        buttonGragientView.snp.makeConstraints { make in
            make.edges.equalTo(startButton)
        }
    }
    
    private func configureStartButton() {
        startButton.clipsToBounds = true
        buttonGragientView.isUserInteractionEnabled = false
        let title = Strings.BreakHabitScreen.startButtonTitle.uppercased()
        startButton.setTitle(title, for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = Fonts.SFProDisplay.medium.font(size: 17)
        startButton.layer.cornerRadius = 12.0
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func startButtonTapped() {
        presenter.startButtonTapped()
    }
}
