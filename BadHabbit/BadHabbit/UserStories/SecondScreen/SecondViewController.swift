//
//  SecondViewController.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.05.23.
//

import UIKit

final class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let viewModel: SecondScreenViewModelProtocol
    private var tableView = UITableView()
    
    init(viewModel: SecondScreenViewModelProtocol) {
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
        print("deinit")
    }
}

extension SecondViewController {
    private func setupUI() {
        let safeArea = view.safeAreaLayoutGuide
        let loadDataButton = UIButton()
        loadDataButton.translatesAutoresizingMaskIntoConstraints = false
        loadDataButton.setTitleColor(.black, for: .normal)
        loadDataButton.setTitle("Load petitions", for: .normal)
        loadDataButton.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 0.7, green: 0.8, blue: 0.6, alpha: 1))
        
        loadDataButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        
        view.addSubview(loadDataButton)
        NSLayoutConstraint.activate([
            loadDataButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            loadDataButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            loadDataButton.heightAnchor.constraint(equalToConstant: 50.0),
            loadDataButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70.0),
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 70.0),
        ])
    }
    
    @objc private func loadButtonTapped() {
        viewModel.loadData()
    }
    
    private func bindVM() {
        viewModel.exampleText = { [weak self] text in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.petitonsCount ?? 0
    }
    
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getTitle(for: indexPath.row)
        return cell
    }
}




