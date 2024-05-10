//
//  NewsImageView.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import UIKit

final class NewsImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 16
        clipsToBounds = true
        contentMode = .scaleAspectFill
        
        backgroundColor = .systemOrange
    }
    
    /// Downloads image with generic Network Manager function
    func downloadImage(article: Article) {
        guard let url = URL(string: article.urlToImage ?? "") else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async { self.image = UIImage(data: data) }
            case .failure(_):
                break
            }
        }
    }
}
