//
//  LayoutConstants.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 25/07/2023.
//

import Foundation

enum LayoutConstants {
    static let leadingInset = 16
    static let trailingInset = 16
    
    enum ActionButton {
        static let height = 50
        static let bottomInset = 20
        static let topOffset = 30
    }
    
    enum ImageLogo {
        static let size: CGFloat = 196
    }
    
    enum CollectionView {
        static func edgeInset(superviewWidth width: CGFloat) -> CGFloat {
            width / 2 - LayoutConstants.ImageLogo.size / 2
        }
    }
}
