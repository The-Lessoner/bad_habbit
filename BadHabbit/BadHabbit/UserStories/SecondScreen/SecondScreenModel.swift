//
//  SecondScreenModel.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.05.23.
//

import Foundation

struct SecondScreenModel: Decodable {
    var results: [Petition]
}

struct Petition: Decodable {
    let title: String
}

