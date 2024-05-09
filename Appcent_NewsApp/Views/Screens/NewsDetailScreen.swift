//
//  NewsDetailScreen.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 8.05.2024.
//

import UIKit

// MARK: - Protocol
protocol NewsDetailScreenProtocol: AnyObject {
    func configureVC()
}

// MARK: - Main Func
final class NewsDetailScreen: UIViewController {
    
    // MARK: - Variables
    private let viewModel = NewsDetailViewModel()
    
    private var favoriteButton: UIBarButtonItem!
    
    private let newsImageView = NewsImageView(frame: .zero)
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Author Label"
        label.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight, width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Date Label"
        label.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight, width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Source Label"
        label.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight, width: .condensed)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Title"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold, width: .expanded)
        label.numberOfLines = 0
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Description Label"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold, width: .standard)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        
        label.text = "News Content Label"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium, width: .standard)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private var goToURLButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Read More", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.backgroundColor = .systemBackground
        
        return button
    } ()
    
    private var url: String!
    
    private var isFavorited: Bool!
    
    private let userDefault = UserDefaultsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    init(article: Article) {
        super.init(nibName: nil, bundle: nil)
        viewModel.article = article
        newsImageView.downloadImage(article: article)
        authorLabel.text = article.author
        dateLabel.text = article.formattedPublishedDate()
        sourceLabel.text = article.source?._name
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        contentLabel.text = article.content
        url = article._url
        isFavorited = userDefault.isArticleFavorited(article)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension
extension NewsDetailScreen: NewsDetailScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        
        configureFavoriteButton()
        updateFavoriteButtonIcon()
        
        addSubviews()
        layoutUI()
        
        goToURLButton.addTarget(self, action: #selector(goToURL), for: .touchUpInside)
    }
    
    private func configureFavoriteButton() {
        favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    private func addSubviews() {
        view.addSubview(newsImageView)
        view.addSubview(authorLabel)
        //        view.addSubview(sourceLabel)
        view.addSubview(dateLabel)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(contentLabel)
        view.addSubview(goToURLButton)
    }
    
    private func layoutUI() {
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding / 2),
            newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding / 2),
            newsImageView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight / 4),
            
            authorLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 2 * padding),
            authorLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
            authorLabel.widthAnchor.constraint(equalToConstant: CGFloat.dWidth / 2),
            
            //            sourceLabel.topAnchor.constraint(equalTo: authorLabel.topAnchor),
            //            sourceLabel.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 2 * padding),
            dateLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 2 * padding),
            titleLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            contentLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor),
            
            goToURLButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: padding / 2),
            goToURLButton.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor)
        ])
    }
    
    private func updateFavoriteButtonIcon() {
        favoriteButton.image = isFavorited ?? false ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    @objc private func favoriteButtonTapped() {
        if !isFavorited {
            userDefault.addFavorite(viewModel.article)
        } else {
            userDefault.removeFavorite(viewModel.article)
        }
        
        isFavorited.toggle()
        
        updateFavoriteButtonIcon()
    }
    
    @objc private func goToURL() {
        guard let url = URL(string: url) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
