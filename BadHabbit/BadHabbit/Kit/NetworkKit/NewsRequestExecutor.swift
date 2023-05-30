//
//  NewsRequestExecutor.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 29/05/2023.
//

import Foundation

protocol NewsRequestExecutorProtocol {
    func perform<Parser: ResponseParserProtocol>(
        request: Request,
        parser: Parser,
        completion: @escaping (Result<Parser.Response, Error>) -> Void
    )
}

class NewsRequestExecutor: NewsRequestExecutorProtocol {
    
    struct Config {
        let scheme: String
        let host: String
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
    }
    
    func perform<Parser: ResponseParserProtocol>(
        request: Request,
        parser: Parser,
        completion: @escaping (Result<Parser.Response, Error>) -> Void
    ) {
        var urlComponents = request.urlComponents()
        urlComponents.scheme = config.scheme
        urlComponents.host = config.host
        
        guard let url = urlComponents.url
        else {
            completion(.failure(NetworkError.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(NetworkError.dataError))
                return
            }
            
            do {
                let response = try parser.parse(data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
