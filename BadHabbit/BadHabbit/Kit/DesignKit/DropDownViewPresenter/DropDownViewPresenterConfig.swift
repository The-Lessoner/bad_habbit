//
//  DropDownViewPresenterConfig.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 1.08.23.
//

import Foundation

struct DropDownViewPresenterConfig {
    let hideOnTapOutside: Bool
    let dropDownOffset: CGFloat
    
    init(
        hideOnTapOutside: Bool = true,
        dropDownOffset: CGFloat = 10.0
    ) {
        self.hideOnTapOutside = hideOnTapOutside
        self.dropDownOffset = dropDownOffset
    }
}
