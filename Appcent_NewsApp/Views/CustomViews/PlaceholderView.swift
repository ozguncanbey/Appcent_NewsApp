//
//  PlaceholderView.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import UIKit

final class PlaceholderView: UIView {
    
    private var placeholderImageView: UIImageView!
    private var placeholderMessage: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        placeholderImageView = UIImageView()
        placeholderMessage = UILabel()
        
        placeholderImageView.image = UIImage(systemName: "magnifyingglass")
        placeholderMessage.text = "Search for news"
        
        addSubview(placeholderImageView)
        addSubview(placeholderMessage)
        
        NSLayoutConstraint.activate([
            placeholderImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeholderImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            
            placeholderMessage.topAnchor.constraint(equalTo: placeholderImageView.bottomAnchor, constant: 10),
            placeholderMessage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
