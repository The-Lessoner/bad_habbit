//
//  NewsViewModel.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 25/05/2023.
//

import Foundation

protocol NewsViewModelProtocol: AnyObject {
    var error: Observable<Error?>? { get set }
    var response: Observable<ArticleResponse?>? { get set }
    var rowCount: Int? { get }
    
    func loadData()
    func title(forRowAtIndex index: Int) -> String?
}

final class NewsViewModel: NewsViewModelProtocol {
    
    var error: Observable<Error?>?
    var response: Observable<ArticleResponse?>?
    
    private var articleResponse: ArticleResponse?
    private let newsService: NewsServiceProtocol
    
    var rowCount: Int? {
        articleResponse?.articles.count
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
                articleResponse = model
                DispatchQueue.main.async {
                    self.response?(self.articleResponse)
                }
            case .failure(let error):
                self.response?(nil)
                self.error?(error)
            }
        }
    }
    
    func title(forRowAtIndex index: Int) -> String? {
        articleResponse?.articles[index].description
    }
}
