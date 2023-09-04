//
//  GradientButton.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 25/08/2023.
//

import UIKit

class GradientButton: UIButton {
    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }
    
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
            guard let layer = self.layer as? CAGradientLayer else { return }
            
            if isEnabled {
                layer.sublayers?.removeAll(where: { layer in
                    layer == darkShadowLayer || layer == lightShadowLayer
                })
                
                layer.startPoint = CGPoint(x: 0.0, y: 0.5)
                layer.endPoint = CGPoint(x: 1.0, y: 0.5)
                layer.colors = [
                    Assets.Colors.darkBlue.color.cgColor,
                    Assets.Colors.purple.color.cgColor
                ]
            } else {
                layer.startPoint = .zero
                layer.endPoint = .zero
                layer.colors = []
                layer.backgroundColor = Assets.Colors.startButtonUnenabledBackground.color.cgColor
                
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
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
