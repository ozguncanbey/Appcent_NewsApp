//
//  News.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import Foundation

// MARK: - News
struct News: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    var _url: String {
        url ?? "No URL"
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
    
    var _name: String {
        "- \(name ?? "No source")"
    }
}

extension Article {
    func formattedPublishedDate() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMM, yy"
        
        if let dateString = publishedAt,
           let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
}
