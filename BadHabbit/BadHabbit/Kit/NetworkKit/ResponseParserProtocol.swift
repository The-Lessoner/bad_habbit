//
//  ResponseParser.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import Foundation

protocol ResponseParserProtocol {
    associatedtype Response
    func parse(_ data: Data) throws -> Response
}
