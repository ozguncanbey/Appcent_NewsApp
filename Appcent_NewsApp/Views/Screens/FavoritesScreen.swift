//
//  FavoritesScreen.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import UIKit

// MARK: - Protocol
protocol FavoritesScreenProtocol: AnyObject {
    func configureVC()
}

// MARK: - Main Func
final class FavoritesScreen: UIViewController {

    // MARK: - Variables
    private let viewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

// MARK: - Extension
extension FavoritesScreen: FavoritesScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
    }
}
