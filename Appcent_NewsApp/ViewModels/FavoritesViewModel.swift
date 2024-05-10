//
//  FavoritesViewModel.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import Foundation

// MARK: - Protocol
protocol FavoritesViewModelProtocol {
    var view: FavoritesScreenProtocol? { get set }
    func viewDidLoad()
    func getfavoritedArticles()
    func removeArticle(_ article: Article)
}

// MARK: - Main Func
final class FavoritesViewModel {
    // MARK: - Variables
    weak var view: FavoritesScreenProtocol?
    var favoritedArticles: [Article] = []
    private let userDefaults = UserDefaultsManager.shared
}

// MARK: - Extension
extension FavoritesViewModel: FavoritesViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureEmptyStateView()
        view?.configureTableView()
        view?.controlData()
        getfavoritedArticles()
    }
    
    func getfavoritedArticles() {
        favoritedArticles = userDefaults.getFavorites()
        view?.controlData()
        view?.reloadTableView()
    }
    
    func removeArticle(_ article: Article) {
        userDefaults.removeFavorite(article)
        view?.controlData()
        view?.reloadTableView()
    }
}
