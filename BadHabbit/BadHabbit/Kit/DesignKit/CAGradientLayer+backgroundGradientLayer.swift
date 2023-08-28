//
//  CAGradientLayer+backgroundGradientLayer.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 25/08/2023.
//

import UIKit

extension CAGradientLayer {
    static func backgroundGradientLayer(colors: [CGColor], inFrame frame: CGRect) -> Self {
        let layer = Self()
        
        layer.colors = colors
        layer.frame = frame
        layer.locations = [0, 0.6]
        
        return layer
    }
}
