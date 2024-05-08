//
//  WebService.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import Foundation

final class WebService {
    
    /// Downloads news and returns article arrays
    func downloadNews(for query: String, at page: Int, completion: @escaping ([Articles]?) -> ()) {
        guard let url = URL(string: API_URLs.newsURL(for: query, at: page)) else { return }
        
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
    
    // Decode the news json and returns data
    private func handleWithData(_ data: Data) -> [Articles]? {
        do {
            let news = try JSONDecoder().decode(News.self, from: data)
            return news.articles
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
