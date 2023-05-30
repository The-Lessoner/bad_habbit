//
//  RequestExecutor.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import Foundation

class RequestExecutorSecondScreen: RequestExecutorProtocol {
    
    struct Config {
        let baseURL: String
    }
    private var requestResponseData: Data
    private var config: Config
    
    init(config: Config, requestResponseData: Data = .init()) {
        self.config = config
        self.requestResponseData = requestResponseData
    }
    //Таблица заполняется по второму нажатию кнопки
    //    потому что с первого раза в requestResponseData не успевают прийти данные :(
    
    func getData(){
        Task{
            if let data = try? await fetchJson(){
                self.requestResponseData = data
            }}
    }
    
    func fetchJson() async throws -> Data {
        let url = URL(string: config.baseURL)!
        let (data, _) = try await URLSession.shared.data(from: url)
        self.requestResponseData = data
        return data
    }
    
    func perform<Parser: ResponseParserProtocol>(
        request: Request,
        parser: Parser,
        completion: (Result<Parser.Response, Error>) -> Void
    ) {
        
        do {
            
            getData()
            let response = try parser.parse(requestResponseData)
            completion(.success(response))
            
        } catch {
            completion(.failure(error))
        }
    }
}


