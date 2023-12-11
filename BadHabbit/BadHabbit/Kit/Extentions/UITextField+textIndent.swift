//
//  UITextField+textIndent.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 21.09.23.
//

import UIKit

extension UITextField {

    func indentLeft(size: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }

    func indentRight(size: CGFloat) {
        self.rightView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.rightViewMode = .always
    }
}
