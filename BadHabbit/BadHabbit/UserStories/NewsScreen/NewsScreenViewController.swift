//
//  NewsScreenViewController.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 28/05/2023.
//

import UIKit

final class NewsScreenViewController: UIViewController {
    
    private let viewModel: NewsViewModelProtocol
    private let loadDataButton = UIButton()
    private lazy var errorLabel = UILabel()
    
    init(viewModel: NewsViewModelProtocol) {
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
        loadDataButton.translatesAutoresizingMaskIntoConstraints = false
        loadDataButton.setTitle("Load news", for: .normal)
        loadDataButton.backgroundColor = .systemGreen
        
        loadDataButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        
        return loadDataButton
    }
    
    private func errorLabelConfigure() {
        errorLabel.textColor = .systemRed
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .justified
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let loadDataButton = loadDataButtonConfigure()
        view.addSubview(loadDataButton)
        
        NSLayoutConstraint.activate([
            loadDataButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            loadDataButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            loadDataButton.heightAnchor.constraint(equalToConstant: 50.0),
            loadDataButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadDataButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let safeArea = view.safeAreaLayoutGuide
        
        errorLabelConfigure()
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            errorLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor),
            errorLabel.leadingAnchor.constraint(equalTo:safeArea.leadingAnchor, constant: 15.0),
            errorLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15.0)
        ])
    }
    
    @objc
    private func loadButtonTapped() {
        DispatchQueue.main.async { [weak self] in
            self?.loadDataButton.removeFromSuperview()
        }
        
        viewModel.loadData()
    }
    
    private func addTableView() {
        let tableView = UITableView(frame: view.safeAreaLayoutGuide.layoutFrame)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TVcell")
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    private func bindVM() {
        viewModel.response = { [weak self] _ in
            self?.addTableView()
        }
        
        viewModel.error = { [weak self] error in
            DispatchQueue.main.async {
                self?.errorLabel.text = error?.localizedDescription
            }
        }
    }
}

extension NewsScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVcell", for: indexPath)
        
        cell.textLabel?.text = viewModel.title(forRowAtIndex: indexPath.row)
        
        return cell
    }
    
    
}
