//
//  LayoutConstants.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 30.07.23.
//

import Foundation

enum LayoutConstants {
    static let leadingOffset = 16
    static let trailingOffset = 16
    static let topOffset = 35
    
    enum ActionButton {
        static let height = 50
        static let bottomOffset = 20
        static let cornerRadius: CGFloat = 12
    }
    enum ImageLogo {
        static let heigth: CGFloat = 196
        static let width: CGFloat = 196
    }
    enum ImageMountains {
        static let heightMultiplier = {
            let imageMountainsMockupHeight: CGFloat = 445
            let superViewMockupHeight: CGFloat = 844
            
            return imageMountainsMockupHeight / superViewMockupHeight
        }()
    }
}
