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
    func configureEmptyFavoritesView()
    func configureTableView()
    func reloadTableView()
    func controlData()
}

// MARK: - Main Func
final class FavoritesScreen: UIViewController {
    
    // MARK: - Variables
    private let viewModel = FavoritesViewModel()
    
    private var emptyFavoritesView: EmptyFavoritesView!
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getfavoritedArticles()
    }
}

// MARK: - Extension
extension FavoritesScreen: FavoritesScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    func configureEmptyFavoritesView() {
        emptyFavoritesView = EmptyFavoritesView(frame: .zero)
        view.addSubview(emptyFavoritesView)
        
        NSLayoutConstraint.activate([
            emptyFavoritesView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyFavoritesView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyFavoritesView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 30),
            emptyFavoritesView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.allowsMultipleSelection = false
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.bounds
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func controlData() {
        if viewModel.favoritedArticles.isEmpty {
            emptyFavoritesView.isHidden = false
            tableView.isHidden = true
        } else {
            emptyFavoritesView.isHidden = true
            tableView.isHidden = false
        }
    }
}

extension FavoritesScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favoritedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID, for: indexPath) as! NewsCell
        cell.set(article: viewModel.favoritedArticles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        DispatchQueue.main.async {
            let newsDetailScreen = NewsDetailScreen(article: self.viewModel.favoritedArticles[indexPath.row])
            self.navigationController?.pushViewController(newsDetailScreen, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat.dHeight / 6
    }
}

