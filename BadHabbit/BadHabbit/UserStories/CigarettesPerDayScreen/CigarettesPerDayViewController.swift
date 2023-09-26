//
//  CigarettesPerDayViewController.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 17/09/2023.
//

import UIKit
import SnapKit

protocol CigarettesPerDayViewProtocol: AnyObject { }

class CigarettesPerDayViewController: BaseViewController, CigarettesPerDayViewProtocol {
    private let presenter: CigarettesPerDayScreenPresenterProtocol
    
    private lazy var backgroundImageView = UIImageView()
    private lazy var nextButton = ActionButton()
    private lazy var textField = TextField(prompt: Strings.CigarettesPerDayScreen.promptText)
    private lazy var errorLabel = UILabel()
    
    init(presenter: CigarettesPerDayScreenPresenterProtocol) {
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
        
        title = Strings.CigarettesPerDayScreen.navigationBarItemTitleText.uppercased()
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
                .font: Fonts.SFProDisplay.semibold.font(size: 24)
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
            string: Strings.CigarettesPerDayScreen.textFieldPlaceHolderText,
            attributes: [
                .foregroundColor: Assets.Colors.gray.color
            ]
        )
    }
    
    private func addNextButton() {
        view.addSubview(nextButton)
        
        nextButton.layer.cornerRadius = AppearanceConstants.ActionButton.cornerRadius
        nextButton.isEnabled = false
        
        nextButton.setTitle(
            Strings.nextButtonTitle.uppercased(),
            for: .normal
        )
        
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitleColor(.black, for: .disabled)
        nextButton.titleLabel?.font = Fonts.SFProDisplay.medium.font(size: 17.0)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setupViewConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.leading.trailing.bottom.equalToSuperview()
        }

        nextButton.snp.makeConstraints { make in
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
    
    private func updateNextButton(isEnabled: Bool) {
        if nextButton.isEnabled != isEnabled {
            nextButton.isEnabled = isEnabled
        }
    }
    
    private func updateTextFieldAppearance(isNeedDisplayRedBottomBorder: Bool) {
        textField.isNeedSetRedAppearance = isNeedDisplayRedBottomBorder
    }
    
    @objc
    private func nextButtonTapped() {
        let isValid = presenter.isValidCigarettesCount(userInput: textField.text)
        
        if isValid {
            presenter.nextButtonTapped()
        } else {
            updateTextFieldAppearance(isNeedDisplayRedBottomBorder: true)
            nextButton.isEnabled = false
        }
    }
}

extension CigarettesPerDayViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.textField.isNeedSetRedAppearance {
            updateTextFieldAppearance(isNeedDisplayRedBottomBorder: false)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if navigationController?.visibleViewController == self,
           let textFieldText = textField.text,
           !textFieldText.isEmpty {
            updateNextButton(isEnabled: true)
        } else {
            updateNextButton(isEnabled: false)
        }
    }
}
