//
//  ValidatedTextField.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 18.09.23.
//

import UIKit

final class ValidatedTextField: UITextField {
    var invalidHintText: String?
    var hintText: String?
    var hintTextIndent: CGFloat?

    lazy var hintLabel: UILabel = {
        let hintLabel = UILabel(frame: CGRect(x: self.frame.minX, y: self.frame.height, width: frame.width - (hintTextIndent ?? 0) * 2, height: 40))
        hintLabel.numberOfLines = 0
        hintLabel.textAlignment = .left
        hintLabel.font = Fonts.SFProDisplay.regular.font(size: 12)
        addSubview(hintLabel)
        return hintLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTextField()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateHintLabelFrame()
    }

    private func configureTextField() {
        addPlaceholder()
        self.textColor = .black
        addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        keyboardType = .numberPad
    }

    @objc private func textFieldEditingDidBegin() {
        textColor = .black
        placeholder = ""
    }

    func validateInput(minValue: Int = 0, maxValue: Int = 0) -> Bool {
        guard let text = text, let value = Int(text) else {
            showInvalidHint(message: invalidHintText ?? "")
            return false
        }

        if value >= minValue && value <= maxValue && text.first != "0"{
            return true
        } else {
            showInvalidHint(message: invalidHintText ?? "")
            return false
        }
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
        textColor = .red
    }

    func showHint(message: String) {
        hintLabel.text = message
        hintLabel.textColor = Assets.Colors.purpleLight.color
    }

    private func updateHintLabelFrame() {
        hintLabel.frame = CGRect(x: self.frame.minX, y: self.frame.height, width: frame.width - (hintTextIndent ?? 0) * 2, height: 40)
    }
}
