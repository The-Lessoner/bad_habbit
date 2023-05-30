//
//  SecondScreenModel.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.05.23.
//

import Foundation

struct SecondScreenModel {
    var results: [Petition]
    init(dictionary: [String: Any]) {
        self.results = []
        for petition in dictionary["results"] as? [[String: Any]] ?? []{
            results.append(Petition(dictionary: petition))
        }
    }
}
struct Petition{
    let title: String
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? ""
    }
}
