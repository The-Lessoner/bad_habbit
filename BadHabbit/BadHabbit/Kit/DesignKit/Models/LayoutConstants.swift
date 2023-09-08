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
        static let itemSize: CGSize = CGSize(width: ImageLogo.size, height: ImageLogo.size)
        static let topInset: CGFloat = 0
        static let bottomInset: CGFloat = 0
        
        static func sideInset(toSuperviewWidth width: CGFloat) -> CGFloat {
            width / 2 - ImageLogo.size / 2
        }
        
        static func minimumLineSpacing(inSuperviewWidth width: CGFloat) -> CGFloat {
            width - ImageLogo.size
        }
    }
}
