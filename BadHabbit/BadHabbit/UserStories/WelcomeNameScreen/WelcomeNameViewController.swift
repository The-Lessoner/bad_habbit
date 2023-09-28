//
//  WelcomeNameViewController.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 15.09.23.
//

import UIKit
import SnapKit

protocol WelcomeNameViewProtocol: AnyObject { }

final class WelcomeNameViewController: BaseViewController, WelcomeNameViewProtocol {
    private lazy var welcomeLabel = UILabel()
    private lazy var imageMountains = UIImageView(image: Assets.Images.mountains.image)
    private lazy var backgroundView = BackgroundGradientView()
    private lazy var startButton = ActionButton()

    private let presenter: WelcomeNameScreenPresenterProtocol

    init(presenter: WelcomeNameScreenPresenterProtocol) {
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

extension WelcomeNameViewController {

    private func setupUI() {

        setupConstraints()

        configureStartButton()
        configureWelcomeLabel()
    }

    private func configureWelcomeLabel() {
        let userFirstName = presenter.userFirstName.uppercased()
        welcomeLabel.textColor = Assets.Colors.darkBlue.color
        welcomeLabel.font = Fonts.SFProDisplay.semibold.font(size: 32.0)
        welcomeLabel.text = Strings.welcome.uppercased() + userFirstName + "!"
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 0
    }

    private func configureStartButton() {
        let title = Strings.next.uppercased()
        startButton.setTitle(title, for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = Fonts.SFProDisplay.medium.font(size: 17)
        startButton.layer.cornerRadius = AppearanceConstants.ActionButton.cornerRadius

        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(imageMountains)
        imageMountains.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.bottom.leading.trailing.equalToSuperview()
        }

        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageMountains.snp.top)
            make.leading.trailing.equalTo(safeArea).inset(LayoutConstants.trailingInset)
            make.centerX.equalTo(safeArea)
        }

        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea).inset(LayoutConstants.ActionButton.bottomInset)
            make.height.equalTo(LayoutConstants.ActionButton.height)
            make.leading.trailing.equalTo(safeArea).inset(LayoutConstants.trailingInset)
        }
    }

    @objc
    private func startButtonTapped() {
        presenter.startButtonTapped()
    }
}
