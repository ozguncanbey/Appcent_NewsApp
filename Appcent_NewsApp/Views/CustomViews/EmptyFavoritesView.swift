//
//  EmptyFavoritesView.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 9.05.2024.
//

import UIKit

final class EmptyFavoritesView: UIView {
    
    // MARK: - Variables
    private var imageView: UIImageView!
    private var messageLabel: UILabel!
    
    let padding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        configureImageView()
        configureMessageLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImageView() {
        imageView = UIImageView(frame: .zero)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.sizeToFit()
        imageView.image = UIImage(systemName: "heart.slash")
        imageView.tintColor = .tertiarySystemFill
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 110),
            imageView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    private func configureMessageLabel() {
        messageLabel = UILabel()
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        messageLabel.textColor = .tertiarySystemFill
        messageLabel.text = "No Favorites Yet"
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            messageLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: padding)
        ])
        
        
    }
}
