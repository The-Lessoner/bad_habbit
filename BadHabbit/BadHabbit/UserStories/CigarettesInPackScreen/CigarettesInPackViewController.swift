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
        
        addTextField()
        addNextButton()
        
        setupViewConstraints()
    }
    
    private func configureBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.image = Assets.Images.mountains.image
    }
    
    private func addTextField() {
        view.addSubview(textField)
        
        textField.delegate = self
        
        textField.textAlignment = .left
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
        
        startButton.setTitle(
            Strings.nextButtonTitle.uppercased(),
            for: .normal
        )
        
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitleColor(.black, for: .disabled)
        startButton.titleLabel?.font = Fonts.SFProDisplay.medium.font(size: 17.0)
        
        startButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
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
    
    @objc
    private func nextButtonTapped() {
        if presenter.isValidCigarettesCount(userInput: textField.text!) {
            presenter.nextButtonTapped()
        } else if textField.isCorrectText {
            textField.isCorrectText = false
        } else if !textField.isCorrectText {
            textField.shake()
        }
    }
}

extension CigarettesInPackViewController: UITextFieldDelegate {
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
}
