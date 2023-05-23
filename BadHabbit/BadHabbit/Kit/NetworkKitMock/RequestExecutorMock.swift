//
//  RequestExecutorMock.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import Foundation

final class RequestExecutorMock: RequestExecutorProtocol {
    
    private let requestResponseData: Data
    
    init(requestResponseData: Data = .init()) {
        self.requestResponseData = requestResponseData
    }
    
    func perform<Parser: ResponseParserProtocol>(
        request: Request,
        parser: Parser,
        completion: (Result<Parser.Response, Error>) -> Void
    ) {
        do {
            let model = try parser.parse(requestResponseData)
            completion(.success(model))
        } catch {
            completion(.failure(error))
        }
    }
}
