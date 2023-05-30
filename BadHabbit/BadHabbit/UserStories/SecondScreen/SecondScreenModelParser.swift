//
//  SecondScreenModelParser.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 25.05.23.
//

import Foundation

final class SecondScreenModelParser: ResponseParserProtocol {
    typealias Response = SecondScreenModel
    
    func parse(_ data: Data) throws -> SecondScreenModel {
    
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
        else {
            throw NetworkError.parseError
        }
        return SecondScreenModel(dictionary: json)
    }
    
}
