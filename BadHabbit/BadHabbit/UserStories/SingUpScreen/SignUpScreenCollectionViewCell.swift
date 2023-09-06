//
//  SignUpScreenCollectionViewCell.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 04/09/2023.
//

import UIKit

final class SignUpScreenCollectionViewCell: UICollectionViewCell {
    static let identifier = "SignUpScreenCollectionViewCell"
    lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewConstraints() {
        imageView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}
