//
//  HorizontalCollectionView.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 07/09/2023.
//

import UIKit

class HorizontalCollectionView: UICollectionView {
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
