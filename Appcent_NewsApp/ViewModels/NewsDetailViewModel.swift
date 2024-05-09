//
//  NewsDetailViewModel.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import Foundation

// MARK: - Protocol
protocol NewsDetailViewModelProtocol {
    var view: NewsDetailScreenProtocol? { get set }
    func viewDidLoad()
}

// MARK: - Main Func
final class NewsDetailViewModel {
    // MARK: - Variables
    weak var view: NewsDetailScreenProtocol?
}

// MARK: - Extension
extension NewsDetailViewModel: NewsDetailViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureVC()
    }
}
