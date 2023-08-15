//
//  EmptyScreen.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 11.08.23.
//

import UIKit

class EmptyScreenAssembly: StoryAssembly {

    func assembleStory() -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = .white
        view.modalPresentationStyle = .fullScreen
        return view
    }
}
