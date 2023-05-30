//
//  SecondViewController.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.05.23.
//

import UIKit

final class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let viewModel: SecondScreenViewModelProtocol
    private var petitions: [Petition]?
    private var tableView: UITableView!
    
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
        
        //bindVM()
    }
    
    deinit {
        print("dinit)")
    }
}

extension SecondViewController {
    private func setupUI() {
        
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
        
        tableView = UITableView(frame: CGRect(x: 0, y: 130, width: view.frame.width, height: view.frame.height - 130))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
    }
    
    @objc private func loadButtonTapped() {
        viewModel.loadData()
        bindVM()
        
    }
    
    private func bindVM() {
        viewModel.exampleText = { [weak self] text in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.petitions = text
                self.tableView.reloadData()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petitions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = petitions?[indexPath.row].title ?? ""
        return cell
    }
}




