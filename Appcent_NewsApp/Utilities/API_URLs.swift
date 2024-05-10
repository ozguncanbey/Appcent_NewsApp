//
//  API_URLs.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import Foundation

enum API_URLs {
    
    static let apiKey = "90f78b5e459f4557a6d285161db89387" /* sometimes there are issue with api's, both of them are below:
                                                           your example api = 90f78b5e459f4557a6d285161db89387, my api = fe5dd6ca68374ea4aff8c73550a00aaf */
    
    static let baseURL = "https://newsapi.org/v2/"
    
    /// returns full url of top_headlines endpoint
    static func top_headlinesURL(at page: Int) -> String {
        "\(baseURL)top-headlines?country=us&page=\(page)&sortBy=publishedAt&apiKey=\(apiKey)"
    }
    
    /// returns full url of search endpoint
    static func searchedNewsURL(for query: String, at page: Int) -> String {
        "\(baseURL)everything?q=\(query)&page=\(page)&sortBy=popularity&apiKey=\(apiKey)"
    }
}
