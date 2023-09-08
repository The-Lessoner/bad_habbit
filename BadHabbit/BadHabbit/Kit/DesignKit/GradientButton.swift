//
//  GradientButton.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 5.09.23.
//

import UIKit

class GradientButton: UIButton {

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGradientLayer()
        layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradientLayer()
    }

    func configureGradientLayer() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.type = .axial
        gradientLayer.colors = [
            Asset.Colors.darkBlueColor.color.cgColor,
            Asset.Colors.purple.color.cgColor
        ]

        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
    }
}
