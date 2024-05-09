//
//  NewsViewModel.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import Foundation

// MARK: - Protocol
protocol NewsViewModelProtocol {
    var view: NewsScreenProtocol? { get set }
    func viewDidLoad()
    func getSerchedNews(for query: String, at page: Int)
    func getTopHeadlines(at page: Int)
}

// MARK: - Main Func
final class NewsViewModel {
    // MARK: - Variables
    weak var view: NewsScreenProtocol?
    private let service = WebService()
    var article: [Article] = []
}

// MARK: - Extension
extension NewsViewModel: NewsViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureSearchBar()
        view?.configureTableView()
        getTopHeadlines(at: 1)
    }
    
    func getTopHeadlines(at page: Int) {
        service.downloadTopHeadlines(at: page) { [weak self] returnedNews in
            guard let self = self else { return }
            guard let returnedNews = returnedNews else { return }
            
            self.article = returnedNews
            self.view?.reloadTableView()
        }
    }
    
    func getSerchedNews(for query: String, at page: Int) {
        service.downloadSearchedNews(for: query, at: page) { [weak self] returnedNews in
            guard let self = self else { return }
            guard let returnedNews = returnedNews else { return }
            
            self.article = returnedNews
            self.view?.reloadTableView()
        }
    }
}
