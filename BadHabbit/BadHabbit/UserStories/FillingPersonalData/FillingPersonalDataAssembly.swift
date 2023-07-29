//
//  FillingPersonalDataAssembly.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 21.07.23.
//

import UIKit

class FillingPersonalDataAssembly: StoryAssembly {
    
    private let alertAssembly: AlertAssemblyProtocol
    
    init(alertAssembly: AlertAssemblyProtocol) {
        self.alertAssembly = alertAssembly
    }
    
    func assembleStory() -> UIViewController {
        let router = FillingPersonalDataRouter()
        let presenter = FillingPersonalDataPresenter(alertAssembly: alertAssembly, router: router)
        let view = FillingPersonalDataViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
