//
//  CigarettesInPackViewController.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 27/09/2023.
//

import UIKit

protocol CigarettesInPackViewProtocol: AnyObject { }

final class CigarettesInPackViewController: BaseViewController, CigarettesInPackViewProtocol {
    private let presenter: CigarettesInPackScreenPresenterProtocol
    
    private lazy var backgroundImageView = UIImageView()
    private lazy var startButton = ActionButton()
    private lazy var textField = TextField(prompt: Strings.cigarettesCountPromptText)
    
    init(presenter: CigarettesInPackScreenPresenterProtocol) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = Strings.CigarettesInPackScreen.titleText.uppercased()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        title = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    private func setupUI() {
        configureBackground()
        configureNavigationBar()
        
        addTextField()
        addNextButton()
        
        setupViewConstraints()
    }
    
    private func configureBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.image = Assets.Images.mountains.image
    }
    
    private func configureNavigationBar() {
        if let navigationController = navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.largeTitleTextAttributes = [
                .font: Fonts.SFProDisplay.semibold.font(size: 24),
                .foregroundColor: UIColor.black
            ]
        }
    }
    
    private func addTextField() {
        view.addSubview(textField)
        
        textField.delegate = self
        
        textField.textAlignment = .center
        textField.font = Fonts.SFProDisplay.regular.font(size: 17)
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(
            string: Strings.CigarettesInPackScreen.textFieldPlaceHolderText,
            attributes: [
                .foregroundColor: Assets.Colors.gray.color
            ]
        )
    }
    
    private func addNextButton() {
        view.addSubview(startButton)
        
        startButton.layer.cornerRadius = AppearanceConstants.ActionButton.cornerRadius
        startButton.isEnabled = false
        
        startButton.setTitle(
            Strings.nextButtonTitle.uppercased(),
            for: .normal
        )
        
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitleColor(.black, for: .disabled)
        startButton.titleLabel?.font = Fonts.SFProDisplay.medium.font(size: 17.0)
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    private func setupViewConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.leading.trailing.bottom.equalToSuperview()
        }

        startButton.snp.makeConstraints { make in
            make.height.equalTo(LayoutConstants.ActionButton.height)
            make.leading.equalTo(safeArea).inset(LayoutConstants.leadingInset)
            make.trailing.equalTo(safeArea).inset(LayoutConstants.trailingInset)
            make.bottom.equalTo(safeArea.snp.bottom).inset(LayoutConstants.ActionButton.bottomInset)
        }
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(LayoutConstants.TextField.height)
            make.leading.equalTo(safeArea).inset(LayoutConstants.leadingInset)
            make.trailing.equalTo(safeArea).inset(LayoutConstants.trailingInset)
            make.top.equalTo(safeArea.snp.top).inset(LayoutConstants.TextField.topInset)
        }
    }
    
    private func updateStartButton(isEnabled: Bool) {
        if startButton.isEnabled != isEnabled {
            startButton.isEnabled = isEnabled
            
            updateStartButtonTitile()
        }
    }
    
    private func updateStartButtonTitile() {
        let title: String
        
        if startButton.isEnabled {
            title = Strings.startButtonTitle.uppercased()
        } else {
            title = Strings.nextButtonTitle.uppercased()
        }
        
        startButton.setTitle(title, for: .normal)
    }
    
    private func updateTextFieldAppearance(isNeedDisplayRedBottomBorder: Bool) {
        textField.isNeedSetRedAppearance = isNeedDisplayRedBottomBorder
    }
    
    @objc
    private func startButtonTapped() {
        let isValid = presenter.isValidCigarettesCount(userInput: textField.text)
        
        if isValid {
            presenter.nextButtonTapped()
        } else {
            updateTextFieldAppearance(isNeedDisplayRedBottomBorder: true)
            updateStartButton(isEnabled: false)
        }
    }
}

extension CigarettesInPackViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.textField.isNeedSetRedAppearance {
            updateTextFieldAppearance(isNeedDisplayRedBottomBorder: false)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if navigationController?.visibleViewController == self,
           let textFieldText = textField.text,
           !textFieldText.isEmpty {
            updateStartButton(isEnabled: true)
        } else {
            updateStartButton(isEnabled: false)
        }
    }
}
