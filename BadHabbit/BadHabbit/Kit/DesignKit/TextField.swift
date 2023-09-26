//
//  TextField.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 17/09/2023.
//

import UIKit

final class TextField: UITextField {
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
        label.textColor = Assets.Colors.red.color
        
        return label
    }()
    
    var isNeedSetRedAppearance: Bool = false {
        didSet {
            if isNeedSetRedAppearance {
                layer.addSublayer(redBottomBorder)
                textColor = Assets.Colors.red.color
                addSubview(promptLabel)
                promptLabel.snp.makeConstraints { make in
                    make.top.equalTo(self.snp.bottom).offset(5)
                    make.leading.equalToSuperview().inset(15)
                }
            } else {
                redBottomBorder.removeFromSuperlayer()
                promptLabel.removeFromSuperview()
                textColor = UIColor.black
            }
        }
    }
    
    init(prompt text: String) {
        promptText = text
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.addSublayer(lineLayer)
    }
}
