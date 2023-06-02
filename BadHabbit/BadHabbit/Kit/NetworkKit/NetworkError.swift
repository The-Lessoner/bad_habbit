//
//  NetworkError.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case dataError(String)
    case parseError
}
