//
//  NewsScreenViewController.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 28/05/2023.
//

import UIKit

final class NewsScreenViewController: UIViewController {
    
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

extension NewsScreenViewController {
    private func loadDataButtonConfigure() -> UIButton {
        let loadDataButton = UIButton()
        loadDataButton.translatesAutoresizingMaskIntoConstraints = false
        loadDataButton.setTitle("Load news", for: .normal)
        loadDataButton.backgroundColor = .systemGreen
        
        loadDataButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        loadDataButton.tag = 1
        
        return loadDataButton
    }
    
    private func textLabelConfigure() {
        textLabel.textColor = .systemBlue
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .justified
    }
    
    private func errorLabelConfigure() {
        errorLabel.textColor = .systemRed
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.numberOfLines = 0
    }
    
    private func setupUI() {
        let loadDataButton = loadDataButtonConfigure()
        view.addSubview(loadDataButton)
        
        NSLayoutConstraint.activate([
            loadDataButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            loadDataButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            loadDataButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06, constant: 0),
            loadDataButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadDataButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        textLabelConfigure()
        view.addSubview(textLabel)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            textLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0)
        ])
        
        errorLabelConfigure()
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
        if let button = view.viewWithTag(1) {
            DispatchQueue.main.async {
                button.removeFromSuperview()
            }
        }
        
        viewModel.loadData()
    }
    
    private func bindVM() {
        viewModel.exampleText = { [weak self] text in
            DispatchQueue.main.async {
                self?.textLabel.text = text
            }
        }
        
        viewModel.error = { [weak self] error in
            DispatchQueue.main.async {
                self?.errorLabel.text = error?.localizedDescription
            }
        }
    }
}
