//
//  UILabel+lineSpacing.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 6.09.23.
//

import UIKit

extension UILabel {

    func setTextWithLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0, for labelText: String?) {
        guard let labelText else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }
}
