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
    func downloadNews(for query: String, at page: Int)
}

// MARK: - Main Func
final class NewsViewModel {
    // MARK: - Variables
    weak var view: NewsScreenProtocol?
    private let service = WebService()
    var articles: [Article] = []
}

// MARK: - Extension
extension NewsViewModel: NewsViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureSearchBar()
        view?.configureTableView()
    }
    
    func downloadNews(for query: String, at page: Int) {
        service.downloadNews(for: query, at: page) { [weak self] returnedNews in
            guard let self = self else { return }
            guard let returnedNews = returnedNews else { return }
            
            self.articles.append(contentsOf: returnedNews)
            self.view?.reloadTableView()
        }
    }
}
