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
    func hideNC()
    func showNC()
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
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.viewWillDisappear()
    }
}

// MARK: - Extension
extension NewsDetailScreen: NewsDetailScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    func hideNC() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func showNC() {
        navigationController?.isNavigationBarHidden = false
    }
}
