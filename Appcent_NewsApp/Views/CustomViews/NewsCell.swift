//
//  NewsCell.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import UIKit

final class NewsCell: UITableViewCell {

    // MARK: - Variables
    static let reuseID = "Cell"
    
    private let newsImageView = NewsImageView(frame: .zero)
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Title"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold, width: .compressed)
        label.numberOfLines = 2
        label.textColor = .systemOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Description Label"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium, width: .compressed)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Date Label"
        label.font = UIFont.systemFont(ofSize: 8, weight: .light, width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Source Label"
        label.font = UIFont.systemFont(ofSize: 8, weight: .light, width: .standard)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    // MARK: - Init Func
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Sets cell
    func set(article: Article) {
        newsImageView.downloadImage(article: article)
        titleLabel.text = article.title ?? "No Title"
        descriptionLabel.text = article.description ?? "No Description"
        dateLabel.text = article.formattedPublishedDate() ?? "No Date"
        sourceLabel.text = article.source?.name ?? "No Source"
    }
    
    private func configure() {
        addSubviews()
        layoutUI()
    }
    
    private func addSubviews() {
        addSubview(newsImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        addSubview(sourceLabel)
    }
    
    private func layoutUI() {
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            newsImageView.widthAnchor.constraint(equalToConstant: CGFloat.dWidth / 3),
            newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding / 2),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -2 * padding),
//            titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding / 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
//            descriptionLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -padding),
            
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2 * padding),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            
            sourceLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            sourceLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 2 * padding),
            sourceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
}
