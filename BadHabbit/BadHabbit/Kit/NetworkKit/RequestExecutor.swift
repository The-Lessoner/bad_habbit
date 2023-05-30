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
        let baseURL: String
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
        if let url = URL(string: request.path) {
            let urlSession = URLSession.shared.dataTask(with: url) {(data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = data else {
                    return
                }
                
                do {
                    let response = try parser.parse(data)
                    completion(.success(response))
                    
                } catch {
                    completion(.failure(error))
                }
            }
            urlSession.resume()
        }
        
    }
}
