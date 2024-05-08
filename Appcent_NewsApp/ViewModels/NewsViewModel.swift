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
}

// MARK: - Main Func
final class NewsViewModel {
    // MARK: - Variables
    weak var view: NewsScreenProtocol?
    
}

// MARK: - Extension
extension NewsViewModel: NewsViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureVC()
    }
}
