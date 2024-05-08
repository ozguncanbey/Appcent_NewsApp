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
}

// MARK: - Main Func
final class FavoritesViewModel {
    // MARK: - Variables
    weak var view: FavoritesScreenProtocol?
}

extension FavoritesViewModel: FavoritesViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureVC()
    }
}
