//
//  MenuView.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 20.09.23.
//

import UIKit

class MenuView: UIView {
    let tableView: UITableView = UITableView()

    var items: [String] = []
    var didSelectItem: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        tableView.addGestureRecognizer(tapGesture)
    }

    private func setupConstraints() {
        addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 8, height: 8)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}

extension MenuView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.tintColor = Assets.Colors.placeholderColor.color
        cell.textLabel?.font = Fonts.SFProDisplay.regular.font(size: 17)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppearanceConstants.CurrencyView.heightForRow
    }

    @objc private func tableViewTapped(sender: UITapGestureRecognizer) {
        let location = sender.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: location) {
            let selectedItem = items[indexPath.row]
            didSelectItem?(selectedItem)
        }
    }
}
