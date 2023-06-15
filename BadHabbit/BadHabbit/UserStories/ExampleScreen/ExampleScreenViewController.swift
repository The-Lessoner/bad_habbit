//
//  ExampleScreenViewController.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import UIKit

final class ExampleScreenViewController: UIViewController {
    
    private let viewModel: ExampleViewModelProtocol
    
    let textLabel = UILabel()
    let errorLabel = UILabel()
    
    init(viewModel: ExampleViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindVM()
    }
    
    deinit {
        print("dinit)")
    }
}

extension ExampleScreenViewController {
    private func setupUI() {
        let loadDataButton = UIButton()
        loadDataButton.translatesAutoresizingMaskIntoConstraints = false
        loadDataButton.setTitle("Load some data", for: .normal)
        loadDataButton.backgroundColor = .systemOrange
        
        loadDataButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        
        view.addSubview(loadDataButton)
        NSLayoutConstraint.activate([
            loadDataButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            loadDataButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            loadDataButton.heightAnchor.constraint(equalToConstant: 50.0),
            loadDataButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0)
        ])
        
        view.addSubview(textLabel)
        textLabel.textColor = .systemBlue
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: loadDataButton.bottomAnchor, constant: 15.0),
            textLabel.centerXAnchor.constraint(equalTo: loadDataButton.centerXAnchor),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0)
        ])
        
        errorLabel.textColor = .systemRed
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.numberOfLines = 0
        view.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 15.0),
            errorLabel.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor, constant: 0.0),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0)
        ])
        
    }
    
    @objc
    private func loadButtonTapped() {
        viewModel.loadData()
    }
    
    private func bindVM() {
        viewModel.exampleText = { [weak self] text in
            self?.textLabel.text = text
        }
        
        viewModel.error = { [weak self] error in
            self?.errorLabel.text = error?.localizedDescription
        }
    }
}
