//
//  EmptyFavoritesView.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 9.05.2024.
//

import UIKit

final class EmptyStateView: UIView {
    
    // MARK: - Variables
    private var imageView: UIImageView!
    private var messageLabel: UILabel!
    
    let padding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        configureImageView(imageSystemName: "")
        configureMessageLabel(message: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(imageSystemName: String, message: String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        configureImageView(imageSystemName: imageSystemName)
        configureMessageLabel(message: message)
    }
    
    private func configureImageView(imageSystemName: String) {
        imageView = UIImageView(frame: .zero)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.sizeToFit()
        imageView.image = UIImage(systemName: imageSystemName)
        imageView.tintColor = .tertiarySystemFill
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 110),
            imageView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    private func configureMessageLabel(message: String) {
        messageLabel = UILabel()
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        messageLabel.textColor = .tertiarySystemFill
        messageLabel.text = message
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            messageLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: padding)
        ])
    }
}
