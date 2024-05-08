//
//  NewsDetailScreen.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import UIKit

// MARK: - Protocol
protocol NewsDetailScreenProtocol: AnyObject {
    func configureVC()
}

// MARK: - Main Func
final class NewsDetailScreen: UIViewController {

    // MARK: - Variables
    private let viewModel = NewsDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

// MARK: - Extension
extension NewsDetailScreen: NewsDetailScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
    }
}
