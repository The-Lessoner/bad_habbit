//
//  DropDownViewPresenterAssembly.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 1.08.23.
//

import UIKit

protocol DropDownViewPresenterAssemblyProtocol {
    func assemble(
        view: UIView,
        dropDownView: UIView,
        config: DropDownViewPresenterConfig
    ) -> DropDownViewPresenterProtocol
}

final class DropDownViewPresenterAssembly: DropDownViewPresenterAssemblyProtocol {
    func assemble(
        view: UIView,
        dropDownView: UIView,
        config: DropDownViewPresenterConfig
    ) -> DropDownViewPresenterProtocol {
        DropDownViewPresenter(view: view, dropDownView: dropDownView, config: config)
    }
}
