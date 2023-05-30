//
//  Request.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import Foundation

struct Request {
    let path: String
    let params: [AnyHashable: Any]
    
    private func urlQueryItems() -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        params.forEach { key, value in
            if let key = key as? String,
               let value = value as? String {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
        }
        
        return queryItems
    }
    
    func urlComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.path = path
        
        let queryItems = urlQueryItems()
        
        guard !queryItems.isEmpty else {
            return urlComponents
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents
    }
}

