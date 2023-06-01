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
    
        guard let response = try? JSONDecoder().decode(SecondScreenModel.self, from: data) else {
                    throw NetworkError.parseError
                }

        return SecondScreenModel(results: response.results)
    }
    
}
