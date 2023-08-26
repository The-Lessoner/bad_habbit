//
//  BackgroundGradientView.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.08.23.
//

import UIKit

class BackgroundGradientView: UIView {

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer? {
        guard let layer = self.layer as? CAGradientLayer else { return nil }
        return layer
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGradientLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradientLayer()
    }

    func configureGradientLayer() {
        guard let gradientLayer = gradientLayer else { return }
        gradientLayer.type = .axial
        gradientLayer.locations = [0, 1]
        gradientLayer.colors = [
            Asset.Colors.backgroundTopColor.color.cgColor,
            Asset.Colors.backgroundBottomColor.color.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.6)
    }
}
