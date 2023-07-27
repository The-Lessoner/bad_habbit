//
//  AlertConfiguration.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 21.07.23.
//

import Foundation

struct AlertConfiguration {
    let title: String?
    let message: String?
    let actions: [AlertAction]?
    
    init(title: String? = nil, message: String? = nil, actions: [AlertAction]? = nil) {
        self.title = title
        self.message = message
        self.actions = actions
    }
}
