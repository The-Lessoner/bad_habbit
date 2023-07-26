//
//  FillingPersonalDataView.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 21.07.23.
//

import UIKit
import SnapKit

protocol FillingPersonalDataViewProtocol: AnyObject {
    func updateName(_ name: String)
}

final class FillingPersonalDataViewController: BaseViewController, FillingPersonalDataViewProtocol {
    
    private lazy var nameLabel = UILabel()
    private lazy var nameInputField = UITextField()
    private lazy var displayNewValueSwitcher = UISwitch()
    
    private let presenter: FillingPersonalDataPresenterProtocol
    
    init(presenter: FillingPersonalDataPresenterProtocol) {
        self.presenter = presenter
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(nameInputField)
        nameInputField.snp.makeConstraints { make in
            make.height.equalTo(50.0)
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        nameInputField.borderStyle = .line
        nameInputField.addTarget(self, action: #selector(nameFieldValueChanged), for: .editingChanged)
        
        view.addSubview(displayNewValueSwitcher)
        displayNewValueSwitcher.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
        }
        
        displayNewValueSwitcher.addTarget(self, action: #selector(switcherValueChanged), for: .valueChanged)
    }
    
    @objc
    private func switcherValueChanged(switcher: UISwitch) {
        presenter.onDisplayNameSwitcherValueChanged(switcher.isOn)
    }
    
    @objc
    private func nameFieldValueChanged(textField: UITextField) {
        presenter.onNameUpdate(name: textField.text ?? "")
    }
}

extension FillingPersonalDataViewController {
    func updateName(_ name: String) {
        nameLabel.text = name
    }
}
