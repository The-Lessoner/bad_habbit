//
//  FillingPersonalDataPresenter.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 21.07.23.
//

import Foundation

protocol FillingPersonalDataPresenterProtocol {
    func onNameUpdate(name: String)
    func onDisplayNameSwitcherValueChanged(_ newValue: Bool)
}

final class FillingPersonalDataPresenter: FillingPersonalDataPresenterProtocol {
    
    private enum DisplayNewNameType {
        case labelOnView
        case alert
    }
    
    weak var view: FillingPersonalDataViewProtocol?
    private let alertAssembly: AlertAssemblyProtocol
    private let router: FillingPersonalDataRouterProtocol
    
    private var displayNewNameType: DisplayNewNameType = .labelOnView
    
    init(alertAssembly: AlertAssemblyProtocol, router: FillingPersonalDataRouterProtocol) {
        self.alertAssembly = alertAssembly
        self.router = router
    }
    
    func onNameUpdate(name: String) {
        switch displayNewNameType {
        case .alert:
            alertAssembly
                .alert(with: AlertConfiguration(title: name, actions: [.ok()]))
                .present()
        case .labelOnView:
            view?.updateName(name)
        }
    }
    
    func onDisplayNameSwitcherValueChanged(_ newValue: Bool) {
        if newValue {
            displayNewNameType = .alert
        } else {
            displayNewNameType = .labelOnView
        }
    }
}
