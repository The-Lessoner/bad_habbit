//
//  RequestExecutor.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import Foundation

protocol RequestExecutorProtocol {
    func perform<Parser: ResponseParserProtocol>(
        request: Request,
        parser: Parser,
        completion: @escaping (Result<Parser.Response, Error>) -> Void
    )
}

class RequestExecutor: RequestExecutorProtocol {
    
    struct Config {
        let scheme: String
        let host: String
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
    }
    
    private func url(for request: Request) -> URL? {
        var urlComponents = request.urlComponents()
        urlComponents.scheme = config.scheme
        urlComponents.host = config.host
        
        return urlComponents.url
    }
    
    func perform<Parser: ResponseParserProtocol>(
        request: Request,
        parser: Parser,
        completion: @escaping (Result<Parser.Response, Error>) -> Void
    ) {
        guard let url = url(for: request)
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
