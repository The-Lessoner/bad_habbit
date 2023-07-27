//
//  Color.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 19/07/2023.
//

import UIKit

extension UIColor {
    // The CSS color value #CC6699 is written as 0xCC6699 in Swift’s hexadecimal number representation.
    convenience init(hexNumber: UInt, alpha: CGFloat = 1.0) {
        let red = (hexNumber & 0xFF0000) >> 16
        let green = (hexNumber & 0x00FF00) >> 8
        let blue = hexNumber & 0x0000FF
        
        self.init(red: CGFloat(red) / 255,
                  green: CGFloat(green) / 255,
                  blue: CGFloat(blue) / 255,
                  alpha: alpha)
    }
}
