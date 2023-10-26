//
//  TextField.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 17/09/2023.
//

import UIKit

final class TextField: UITextField {
    private let boundsXInset: CGFloat = 15.5
    private var promptText: String
    
    private lazy var lineLayer: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 0.0, y: frame.size.height - 1.0, width: frame.size.width, height: 1.0)
        layer.backgroundColor = Assets.Colors.purpleLight.color.cgColor
        
        return  layer
    }()
    
    private lazy var redBottomBorder: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 0.0, y: frame.size.height - 1.0, width: frame.size.width, height: 1.0)
        layer.backgroundColor = Assets.Colors.red.color.cgColor
        
        return  layer
    }()
    
    private lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.text = promptText
        label.font = Fonts.SFProDisplay.regular.font(size: 12)
        
        return label
    }()
    
    var isCorrectText: Bool = true {
        didSet {
            if isCorrectText {
                redBottomBorder.removeFromSuperlayer()
                changePromptLabelText()
                setComponentsTextColor(UIColor.black)
            } else {
                layer.addSublayer(redBottomBorder)
                changePromptLabelText()
                setComponentsTextColor(Assets.Colors.red.color)
                shake()
            }
        }
    }
    
    init(prompt: String) {
        promptText = prompt
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.addSublayer(lineLayer)
        
        addSubview(promptLabel)
        promptLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(15)
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: boundsXInset, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: boundsXInset, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: boundsXInset, dy: 0)
    }
    
    private func setComponentsTextColor(_ color: UIColor) {
        textColor = color
        promptLabel.textColor = color
    }
    
    private func changePromptLabelText() {
        if let text = text,
           text.isEmpty,
           promptLabel.text == promptText {
            promptLabel.text = Strings.emptyLabelPromptText
        } else if promptLabel.text != promptText {
            promptLabel.text = promptText
        }
    }
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position.x")
        
        animation.fromValue = NSValue(cgPoint: CGPoint(
            x: self.center.x - 5,
            y: self.center.y
        ))
        animation.toValue = NSValue(cgPoint: CGPoint(
            x: self.center.x + 5,
            y: self.center.y
        ))
        
        animation.repeatCount = 2
        animation.duration = 0.04
        animation.autoreverses = true
        
        layer.add(animation, forKey: "position.x")
    }
}
