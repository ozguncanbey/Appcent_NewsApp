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
    func configureSearchBar()
    func configureTableView()
    func configureEmptyStateView()
    func reloadTableView()
    func controlData()
}

// MARK: - Main Func
final class NewsScreen: UIViewController {
    
    // MARK: - Variables
    private let viewModel = NewsViewModel()
    
    private var emptyStateView: EmptyStateView!
    
    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    
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
    
    func configureSearchBar() {
        searchBar = UISearchBar(frame: .zero)
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.placeholder = "Enter a query..."
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.returnKeyType = .done
        
        searchBar.delegate = self
        
        searchBar.showsCancelButton = true
        
        searchBar.becomeFirstResponder()
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
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
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureEmptyStateView() {
        emptyStateView = EmptyStateView(imageSystemName: "magnifyingglass", message: "Search for news..")
        view.addSubview(emptyStateView)
        
        NSLayoutConstraint.activate([
            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 30),
            emptyStateView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func controlData() {
        NewsScreen.toggleViews(condition: viewModel.article.isEmpty, firstView: emptyStateView, secondView: tableView)
    }
}

extension NewsScreen: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            emptyStateView.isHidden = true
            tableView.isHidden = false
            // page must be 1, article must be []
            viewModel.reset(isQ: false, isP: true)
            viewModel.query = searchText
            viewModel.getSerchedNews(for: viewModel.query, at: 1)
        }
        else {
//            viewModel.getTopHeadlines(at: 1)
            
            // query must be "", page must be 1, article must be []
            viewModel.reset(isQ: true, isP: true)
            
            controlData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
//        viewModel.getTopHeadlines(at: 1)
                
        // query must be "", page must be 1, article must be []
        viewModel.reset(isQ: true, isP: true)
        
        controlData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension NewsScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.article.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID, for: indexPath) as! NewsCell
        cell.set(article: viewModel.article[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        DispatchQueue.main.async {
            let newsDetailScreen = NewsDetailScreen(article: self.viewModel.article[indexPath.row])
            self.navigationController?.pushViewController(newsDetailScreen, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat.dHeight / 6
    }
    
    // If indicator is at nearly %80 of the screen, getSerchedNews function be called
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (2 * height) {
            if !viewModel.query.isEmpty {
                viewModel.page += 1
                viewModel.getSerchedNews(for: viewModel.query, at: viewModel.page)
            }
        }
    }
}
