//
//  UITextField+bottomLine.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 21.09.23.
//

import UIKit

extension UITextField {
    
    func addBottomLine(color: UIColor, height: CGFloat) {
        let bottomLine = UIView()
        bottomLine.backgroundColor = color
        addSubview(bottomLine)

        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(height)
        }
    }
}
