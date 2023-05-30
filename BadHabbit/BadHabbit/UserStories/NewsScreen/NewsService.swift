//
//  NewsService.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 25/05/2023.
//

import Foundation

protocol NewsServiceProtocol {
    func loadExampleData(completion: @escaping (Result<ArticleResponse, Error>) -> Void)
}

final class NewsService: NewsServiceProtocol {
    
    private let requestExecutor: RequestExecutorProtocol
    
    init(requestExecutor: RequestExecutorProtocol) {
        self.requestExecutor = requestExecutor
    }
    
    func loadExampleData(completion: @escaping (Result<ArticleResponse, Error>) -> Void) {
        let request = Request(path: "/v2/everything",
                              params: ["apiKey": "8a5d4afb45544923bdc9eeec46207f17",
                                       "language": "en",
                                       "q": "Apple Inc",
                                       "from": "2023-05-23",
                                       "to": "2023-05-24",
                                       "page": "1",
                                       "pageSize": "1",
                                       "sortBy": "publishedAt"])
        
        let parser = NewsModelParser()
        
        requestExecutor.perform(request: request,
                                parser: parser,
                                completion: completion)
    }
}
