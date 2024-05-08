//
//  NewsScreen.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import UIKit

// MARK: - Protocol
protocol NewsScreenProtocol: AnyObject {
    func configureVC()
}

// MARK: - Main Func
final class NewsScreen: UIViewController {

    // MARK: - Variables
    private let viewModel = NewsViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

// MARK: - Extension
extension NewsScreen: NewsScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
    }
}
