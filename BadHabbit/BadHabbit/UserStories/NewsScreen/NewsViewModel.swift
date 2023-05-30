//
//  NewsViewModel.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 25/05/2023.
//

import Foundation

final class NewsViewModel: ExampleViewModelProtocol {
    
    var error: Observable<Error?>?
    var exampleText: Observable<String?>? {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name.textChanged, object: nil)
        }
    }
    
    private let newsService: NewsServiceProtocol
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    func loadData() {
        newsService.loadExampleData { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                self.error?(nil)
                self.exampleText?(model.articles[0].description)
            case .failure(let error):
                self.error?(error)
                self.exampleText?(nil)
            }
        }
    }
}
