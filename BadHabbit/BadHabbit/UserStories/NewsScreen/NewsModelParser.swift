//
//  NewsModelParser.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 28/05/2023.
//

import Foundation

final class NewsModelParser: ResponseParserProtocol {
    typealias Response = ArticleResponse
    
    func parse(_ data: Data) throws -> ArticleResponse {
        let decoder = JSONDecoder()
         
        guard let response = try? decoder.decode(ArticleResponse.self, from: data) else {
            throw NetworkError.parseError
        }
        
        return response
    }
}
