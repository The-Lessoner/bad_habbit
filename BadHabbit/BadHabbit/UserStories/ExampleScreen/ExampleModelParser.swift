//
//  ExampleModelParser.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import Foundation

final class ExampleModelParser: ResponseParserProtocol {
    typealias Response = ExampleModel
    
    func parse(_ data: Data) throws -> ExampleModel {
        guard
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let text = json["text"] as? String
        else {
            throw NetworkError.parseError
        }
        
        return ExampleModel(text: text)
    }
}
