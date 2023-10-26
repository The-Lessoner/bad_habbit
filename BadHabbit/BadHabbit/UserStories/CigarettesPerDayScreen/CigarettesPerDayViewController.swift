//
//  CigarettesPerDayViewController.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 17/09/2023.
//

import UIKit
import SnapKit

protocol CigarettesPerDayViewProtocol: AnyObject { }

final class CigarettesPerDayViewController: BaseViewController, CigarettesPerDayViewProtocol {
    private let presenter: CigarettesPerDayScreenPresenterProtocol
    
    private lazy var backgroundImageView = UIImageView()
    private lazy var nextButton = ActionButton()
    private lazy var textField = TextField(prompt: Strings.cigarettesCountPromptText)
    
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
        
        title = Strings.CigarettesPerDayScreen.titleText.uppercased()
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
        
        textField.textAlignment = .left
        textField.font = Fonts.SFProDisplay.regular.font(size: 17)
        textField.keyboardType = .numberPad
        
        let placeholderFontSize: CGFloat = UIScreen.main.bounds.width > 390 ? 17 : 16
        textField.attributedPlaceholder = NSAttributedString(
            string: Strings.CigarettesPerDayScreen.textFieldPlaceHolderText,
            attributes: [
                .foregroundColor: Assets.Colors.gray.color,
                .font: Fonts.SFProDisplay.regular.font(size: placeholderFontSize)
            ]
        )
    }
    
    private func addNextButton() {
        view.addSubview(nextButton)
        
        nextButton.layer.cornerRadius = AppearanceConstants.ActionButton.cornerRadius
        
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
    
    @objc
    private func nextButtonTapped() {
        if let text = textField.text,
           let count = Int(text),
           presenter.isValidCigarettesCount(count) {
            presenter.nextButtonTapped()
        } else if textField.isCorrectText {
            textField.isCorrectText = false
        } else if !textField.isCorrectText {
            textField.shake()
        }
    }
}

extension CigarettesPerDayViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !self.textField.isCorrectText {
            self.textField.isCorrectText = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty || Int(string) != nil {
            return true
        } else {
            self.textField.shake()
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text,
        text.hasPrefix("0"),
        let value = Int(text) {
            textField.text = String(value)
        }
    }
}
