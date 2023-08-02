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
    }
    
    enum BackgroundImage {
        static let heightMultiplier = {
            let signUpScreenMockupBackgroundImageHeight: CGFloat = 445
            let signUpScreenMockupHeight: CGFloat = 844
            
            return signUpScreenMockupBackgroundImageHeight / signUpScreenMockupHeight
        }()
    }
}
