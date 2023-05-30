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
    
//    func parse(_ data: Data) throws -> ArticleModel {
//        guard
//            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
//            let text = json["text"] as? String
//        else {
//            throw NetworkError.parseError
//        }
//
//        return ArticleModel(title: <#T##String?#>, description: <#T##String?#>, url: <#T##String?#>)
//    }
}
