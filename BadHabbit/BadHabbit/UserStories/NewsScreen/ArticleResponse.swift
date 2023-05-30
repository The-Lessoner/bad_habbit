//
//  ArticleResponse.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 29/05/2023.
//

import Foundation

struct ArticleResponse: Decodable {
    
    struct Article: Decodable {
        let description: String?
    }
    
    var articles: [Article]
}
