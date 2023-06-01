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
    
    private func getUrl(for request: Request) -> URL? {
        var components = URLComponents()
        components.scheme = config.scheme
        components.host = config.host
        components.path = request.path
        return components.url
    }
    
    func perform<Parser: ResponseParserProtocol>(
        request: Request,
        parser: Parser,
        completion: @escaping (Result<Parser.Response, Error>) -> Void
    ) {
        
        guard let url = getUrl(for: request) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        let urlSession = URLSession.shared.dataTask(with: url) {(data, response, error) in
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
        }
        urlSession.resume()
    }
}
