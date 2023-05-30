//
//  NewsViewModel.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 25/05/2023.
//

import Foundation

protocol NewsViewModelProtocol: AnyObject {
    var error: Observable<Error?>? { get set }
    var exampleText: Observable<ArticleResponse?>? { get set }
    var rowCount: Int? { get }
    
    func loadData()
    func title(forRowAtIndex index: Int) -> String?
}

final class NewsViewModel: NewsViewModelProtocol {
    
    var error: Observable<Error?>?
    var exampleText: Observable<ArticleResponse?>?
    
    private var response: ArticleResponse?
    private let newsService: NewsServiceProtocol
    
    var rowCount: Int? {
        response?.articles.count
    }
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    func loadData() {
        newsService.loadExampleData { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                self.error?(nil)
                response = model
                self.exampleText?(model)
            case .failure(let error):
                self.error?(error)
                self.exampleText?(nil)
            }
        }
    }
    
    func title(forRowAtIndex index: Int) -> String? {
        response?.articles[index].description
    }
}
