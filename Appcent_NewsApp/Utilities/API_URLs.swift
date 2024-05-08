//
//  API_URLs.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import Foundation

enum API_URLs {
    
    static let apiKey = "fe5dd6ca68374ea4aff8c73550a00aaf"
    static let baseURL = "https://newsapi.org/v2/"
    
    static func newsURL(for query: String, at page: Int) -> String {
        "\(baseURL)everything?q=\(query)&page=\(page)&apiKey=\(apiKey)"
    }
}
