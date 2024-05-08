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
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold, width: .expanded)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Description Label"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium, width: .standard)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Date Label"
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium, width: .standard)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Source Label"
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium, width: .standard)
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
        descriptionLabel.text = article.content ?? "No Description"
        dateLabel.text = article.formattedPublishedDate() ?? "No Date"
        sourceLabel.text = article.description ?? "No Source"
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
        
    }
}
