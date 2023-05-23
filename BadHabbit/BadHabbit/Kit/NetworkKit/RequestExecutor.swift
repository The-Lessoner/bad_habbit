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
        completion: (Result<Parser.Response, Error>) -> Void
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
        completion: (Result<Parser.Response, Error>) -> Void
    ) {
        do {
            let response = try parser.parse(Data())
            completion(.success(response))
        } catch {
            completion(.failure(error))
        }
    }
}
