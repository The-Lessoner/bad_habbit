//
//  AlertAction.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 21.07.23.
//

import Foundation

struct AlertAction {
    let title: String
    let handler: VoidClosure?
}

extension AlertAction {
    static func ok(handler: VoidClosure? = nil) -> Self {
        // TODO: - Check if localization is needed
        return .init(title: "OK", handler: handler)
    }
}
