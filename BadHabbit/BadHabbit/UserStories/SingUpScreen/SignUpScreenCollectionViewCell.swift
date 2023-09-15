//
//  SignUpScreenCollectionViewCell.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 04/09/2023.
//

import UIKit

final class SignUpScreenCollectionViewCell: UICollectionViewCell {
    static let identifier = "SignUpScreenCollectionViewCell"
    private lazy var imageView = UIImageView(frame: self.bounds)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage) {
        imageView.image = image
    }
}
