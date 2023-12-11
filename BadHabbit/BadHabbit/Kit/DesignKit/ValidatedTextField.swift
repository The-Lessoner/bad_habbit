//
//  ValidatedTextField.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 18.09.23.
//

import UIKit

final class ValidatedTextField: UITextField {
    var hintText: String?
    var hintTextIndent: CGFloat?
    private var bottomLineView: UIView?

    lazy var hintLabel: UILabel = {
        let hintLabel = UILabel(frame: CGRect(x: self.frame.minX, y: self.frame.height, width: frame.width - (hintTextIndent ?? 0) * 2, height: 40))
        hintLabel.numberOfLines = 0
        hintLabel.textAlignment = .left
        hintLabel.font = Fonts.SFProDisplay.regular.font(size: 12)
        hintLabel.text = hintText
        addSubview(hintLabel)
        return hintLabel
    }()

    init(hintText: String) {
        self.hintText = hintText
        super.init(frame: .zero)
        configureTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateHintLabelFrame()
        updateBottomLineFrame()
    }

    private func configureTextField() {
        addPlaceholder()
        addBottomLineView()
        setAppereance(isValid: true)
        addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        keyboardType = .decimalPad
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [doneButton]

        self.inputAccessoryView = toolbar
    }

    @objc func doneButtonTapped() {
        self.resignFirstResponder()
    }

    @objc private func textFieldEditingDidBegin() {
        setAppereance(isValid: true)
    }

    func validateInput(minValue: Double = 0, maxValue: Double = 0) -> Bool {
        if let text {
            guard  let value = Double(text.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: ".")) else {
                setAppereance(isValid: false)
                return false
            }

            if value >= minValue && value <= maxValue && text.first != "0"{
                return true
            } else {
                setAppereance(isValid: false)
                return false
            }
        }
        return false
    }

    private func addPlaceholder() {
        let placeholderText = NSAttributedString(
            string: self.placeholder ?? "",
            attributes: [.font: Fonts.SFProDisplay.regular.font(size: 17),
                         .foregroundColor: Assets.Colors.placeholderColor.color]
        )
        self.attributedPlaceholder = placeholderText
    }

    private func showInvalidHint(message: String) {
        hintLabel.text = message
        hintLabel.textColor = .red
    }

    func showHint(message: String) {
        hintLabel.text = message
        hintLabel.textColor = Assets.Colors.purpleLight.color
    }

    func setAppereance(isValid: Bool) {
        if isValid {
            textColor = .black
            bottomLineView?.backgroundColor = Assets.Colors.purpleLight.color
            showHint(message: hintText ?? "")
        } else {
            textColor = .red
            bottomLineView?.backgroundColor = .red
            showInvalidHint(message: hintText ?? "")
        }
    }

    private func updateHintLabelFrame() {
        hintLabel.frame = CGRect(x: self.frame.minX, y: self.frame.height, width: frame.width - (hintTextIndent ?? 0) * 2, height: 40)
    }

    private func addBottomLineView() {
        let bottomLineView = UIView(frame: CGRect(x: 0, y: self.bounds.height - 1, width: self.bounds.width, height: 1))
        bottomLineView.backgroundColor = Assets.Colors.purpleLight.color
        addSubview(bottomLineView)
        self.bottomLineView = bottomLineView
    }

    private func updateBottomLineFrame() {
        bottomLineView?.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
