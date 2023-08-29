//
//  BackgroundGradientView.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 29/08/2023.
//

import UIKit

class BackgroundGradientView: GradientView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        if let layer = self.layer as? CAGradientLayer {
            layer.locations = [0.0, 0.6]
            layer.colors = [
                Assets.Colors.gradientBackgroundBegin.color.cgColor,
                Assets.Colors.gradientBackgroundEnd.color.cgColor
            ]
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
