//
//  CanPresentView.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.07.23.
//

import UIKit

protocol CanPresentView {
    func present(_ viewController: UIViewController, animated: Bool, completion: VoidClosure?)
}

extension CanPresentView {
    func present(
        _ viewController: UIViewController
    ) {
        present(viewController, animated: true, completion: nil)
    }
}
