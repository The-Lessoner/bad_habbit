//
//  GradientButton.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 25/08/2023.
//

import UIKit

class ActionButton: UIButton {
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.colors = [
            Assets.Colors.darkBlue.color.cgColor,
            Assets.Colors.purple.color.cgColor
        ]
        
        return  gradientLayer
    }()
    
    private lazy var darkShadowLayer: CALayer = {
        let shadowLayer = CALayer()
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.25
        shadowLayer.shadowRadius = 1.0
        
        return  shadowLayer
    }()
    
    private lazy var lightShadowLayer: CALayer = {
        let shadowLayer = CALayer()
        
        shadowLayer.shadowColor = UIColor.white.cgColor
        shadowLayer.shadowOffset = CGSize(width: -2.0, height: -2.0)
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.shadowRadius = 1.0
        
        return  shadowLayer
    }()
    
    override var isEnabled: Bool {
        didSet {
            switch isEnabled {
            case true:
                darkShadowLayer.removeFromSuperlayer()
                lightShadowLayer.removeFromSuperlayer()
                
                layer.insertSublayer(gradientLayer, at: 0)
            case false:
                if let sublayers = layer.sublayers,
                   sublayers.contains(where: { $0 == gradientLayer }) {
                    gradientLayer.removeFromSuperlayer()
                }
                
                layer.addSublayer(darkShadowLayer)
                layer.addSublayer(lightShadowLayer)
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let roundedRectReversing = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).reversing()
        
        let darkShadowPath = UIBezierPath(roundedRect: bounds.insetBy(dx: 0.5, dy: 0.5), cornerRadius: layer.cornerRadius)
        darkShadowPath.append(roundedRectReversing)
        
        let ligthShadowPath = UIBezierPath(roundedRect: bounds.insetBy(dx: -1, dy: -2), cornerRadius: layer.cornerRadius)
        ligthShadowPath.append(roundedRectReversing)
        
        darkShadowLayer.shadowPath = darkShadowPath.cgPath
        lightShadowLayer.shadowPath = ligthShadowPath.cgPath
        
        gradientLayer.frame = bounds
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        layer.backgroundColor = Assets.Colors.startButtonUnenabledBackground.color.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
