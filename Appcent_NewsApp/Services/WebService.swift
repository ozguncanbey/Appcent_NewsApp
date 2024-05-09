//
//  WebService.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import Foundation

final class WebService {
    
    /// Downloads top headlines news and returns article arrays
    func downloadTopHeadlines(at page: Int, completion: @escaping ([Article]?) -> ()) {
        guard let url = URL(string: API_URLs.top_headlinesURL(at: page)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    /// Downloads searched news and returns article arrays
    func downloadSearchedNews(for query: String, at page: Int, completion: @escaping ([Article]?) -> ()) {
        guard let url = URL(string: API_URLs.searchedNewsURL(for: query, at: page)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    // When error occurs
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    // Decode the news from json and returns data as Articles array
    private func handleWithData(_ data: Data) -> [Article]? {
        do {
            let news = try JSONDecoder().decode(News.self, from: data)
            return news.articles
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
