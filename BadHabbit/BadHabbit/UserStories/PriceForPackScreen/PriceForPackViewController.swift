//
//  PriceForPackViewController.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 6.09.23.
//

import UIKit
import SnapKit

protocol PriceForPackViewProtocol: AnyObject { }

final class PriceForPackViewController: BaseViewController, PriceForPackViewProtocol {
    private lazy var titleLabel = UILabel()
    private lazy var imageMountains = UIImageView(image: Assets.Images.mountains.image)
    private lazy var backgroundView = BackgroundGradientView()
    private lazy var startButton = ActionButton()
    private lazy var priceValidatedTextField = ValidatedTextField()
    private lazy var currencyTextField = UITextField()
    private lazy var currencyMenuView = MenuView()

    private lazy var currencyMenuPresenter = DropDownViewPresenter(
        view: currencyTextField,
        dropDownView: currencyMenuView
    )

    private lazy var hintText = Strings.PriceForPack.PriceValidatedTextField.HintLabelText.valid
    private let presenter: PriceForPackScreenPresenterProtocol

    init(presenter: PriceForPackScreenPresenterProtocol) {
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

extension PriceForPackViewController {

    private func setupUI() {
        currencyMenuPresenter.dropDownOffset = 0
        currencyMenuView.items = presenter.currencies

        setupConstraints()
        configureStartButton()
        configureTitleLabel()
        configurePriceValidatedTextField()
        configureCurrencyTextField()
    }

    private func configurePriceValidatedTextField() {
        priceValidatedTextField.delegate = self
        priceValidatedTextField.invalidHintText = Strings.PriceForPack.PriceValidatedTextField.HintLabelText.invalid
        priceValidatedTextField.addBottomLine(color: Assets.Colors.purpleLight.color, height: 1)
        priceValidatedTextField.showHint(message: hintText)
        priceValidatedTextField.placeholder = Strings.PriceForPack.pricePlaceholder
        priceValidatedTextField.indentLeft(size: AppearanceConstants.PriceValidatedTextField.indentLeft)
        priceValidatedTextField.indentRight(size: AppearanceConstants.PriceValidatedTextField.indentRight)
        priceValidatedTextField.hintTextIndent = AppearanceConstants.PriceValidatedTextField.indentLeft
    }

    private func configureCurrencyTextField() {
        currencyTextField.delegate = self
        currencyTextField.textAlignment = .center
        currencyTextField.textColor = Assets.Colors.purpleLight.color
        currencyTextField.addBottomLine(color: Assets.Colors.purpleLight.color, height: 1)
    }

    private func configureTitleLabel() {
        titleLabel.textColor = .black
        titleLabel.font = Fonts.SFProDisplay.semibold.font(size: 24.0)
        titleLabel.text = Strings.PriceForPack.title.uppercased()
        titleLabel.textAlignment = .left
    }

    private func configureStartButton() {
        let title = Strings.next.uppercased()
        startButton.isEnabled = false
        startButton.setTitle(title, for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitleColor(.black, for: .disabled)
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

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea)
            make.leading.trailing.equalTo(safeArea).inset(LayoutConstants.trailingInset)
        }

        view.addSubview(imageMountains)
        imageMountains.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.bottom.leading.trailing.equalToSuperview()
        }

        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea).inset(LayoutConstants.ActionButton.bottomInset)
            make.height.equalTo(LayoutConstants.ActionButton.height)
            make.leading.trailing.equalTo(safeArea).inset(LayoutConstants.trailingInset)
        }

        view.addSubview(priceValidatedTextField)
        priceValidatedTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).inset(42)
            make.leading.equalTo(safeArea).inset(LayoutConstants.leadingInset)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(50)
        }

        view.addSubview(currencyTextField)
        currencyTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).inset(42)
            make.width.equalTo(74)
            make.height.equalTo(50)
            make.trailing.equalTo(safeArea).inset(LayoutConstants.trailingInset)
            make.leading.equalTo(priceValidatedTextField.snp.trailing).offset(20)
        }
    }

    @objc
    private func startButtonTapped() {
        let isValid = priceValidatedTextField.validateInput(minValue: 1, maxValue: 999999)
        
        if isValid {
            presenter.startButtonTapped()
        } else {
            startButton.isEnabled = false
        }
    }

    func currencyTextFieldTapped() {
        let height = AppearanceConstants.CurrencyView.heightForRow * CGFloat(presenter.currenciesCount)
        currencyMenuPresenter.showDropDown(preferredSize: CGSize(width: UIView.noIntrinsicMetric, height: height), animated: true)

        currencyMenuView.didSelectItem = {  [weak self] currency in
            DispatchQueue.main.async {
                self?.currencyTextField.text = currency
                self?.checkIfAllFieldsFull()
            }
        }
        view.endEditing(true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        checkIfAllFieldsFull()

        if priceValidatedTextField.text?.isEmpty == true {
            priceValidatedTextField.placeholder = Strings.PriceForPack.pricePlaceholder
            priceValidatedTextField.showHint(message: hintText)
        }
    }

    func checkIfAllFieldsFull() {
        if priceValidatedTextField.text?.isEmpty == false && currencyTextField.text?.isEmpty == false {
            startButton.isEnabled = true
        }
    }
}

extension PriceForPackViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == priceValidatedTextField {
            let textCount = textField.text?.count ?? 0
            if textCount >= 1 && currencyTextField.text != nil {
                startButton.isEnabled = true
            } else {
                startButton.isEnabled = false
            }
        }
        if textField == currencyTextField {
            currencyTextFieldTapped()
            return false
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count ?? 0) + string.count - range.length
        if newLength >= 1 {
            priceValidatedTextField.hintLabel.text = ""
        } else {
            startButton.isEnabled = false
        }

        let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        if let indentLeft = textField.leftView?.frame.width, let indentRight = textField.rightView?.frame.width {
            let textWidth = textField.frame.width - indentLeft - indentRight
            let textSize = (currentText as NSString).size(withAttributes: [.font: textField.font ?? UIFont.systemFont(ofSize: 17)])
            if textSize.width > textWidth {
                return false
            }
        }
        return true
    }
}
