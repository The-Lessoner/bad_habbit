//
//  SwipeGestureRecognizer.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 15/08/2023.
//

import UIKit

enum SwipeGestureRecognizer {
    static let left: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer()
        recognizer.direction = .left
        
        return recognizer
    }()
    
    static let right: UISwipeGestureRecognizer = {
        let recognizer = UISwipeGestureRecognizer()
        recognizer.direction = .right
        
        return recognizer
    }()
}
