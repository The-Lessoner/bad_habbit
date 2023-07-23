//
//  AlertController.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 21.07.23.
//

import UIKit

protocol AlertControllerViewProtocol: AnyObject {
    func addAction(_ action: AlertAction)
}

final class AlertController: UIAlertController & AlertControllerViewProtocol {
    
    convenience init(presenter: AlertPresenterProtocol) {
        self.init(
            title: presenter.title,
            message: presenter.message,
            preferredStyle: .alert
        )
    }
    
    func addAction(_ action: AlertAction) {
        addAction(UIAlertAction(
            title: action.title,
            style: .default,
            handler: { _ in action.handler?() }
        ))
    }
}
