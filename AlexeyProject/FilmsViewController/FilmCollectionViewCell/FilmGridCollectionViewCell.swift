//
//  FilmViewController.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import UIKit
import SDWebImage

final class FilmGridCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    private let posterImageView = UIImageView()
    private let ratingImageView = UIImageView()
    private let titleLabel = UILabel()
    private let releaseLabel = UILabel()
    private let voteLabel = UILabel()
    private let baseImageUrl = ServiceManager()
    
    //MARK: - Lifecycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setup() {
        addSubviews()
        layout()
        setupImageView()
        setupLabel()
        posterImageView.backgroundColor = .clear
    }
    
    private func addSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(ratingImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseLabel)
        contentView.addSubview(voteLabel)
    }
    
    private func layout(){
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        ratingImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseLabel.translatesAutoresizingMaskIntoConstraints = false
        voteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 6),
            titleLabel.bottomAnchor.constraint(equalTo: releaseLabel.topAnchor, constant: -4),
            
            releaseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            releaseLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 6),
            releaseLabel.bottomAnchor.constraint(equalTo: ratingImageView.topAnchor, constant: -4),
            
            ratingImageView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 6),
            ratingImageView.heightAnchor.constraint(equalToConstant: 15),
            ratingImageView.widthAnchor.constraint(equalToConstant: 15),
            ratingImageView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -2),
            
            voteLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -6),
            voteLabel.leadingAnchor.constraint(equalTo: ratingImageView.trailingAnchor, constant: 6),
            voteLabel.centerYAnchor.constraint(equalTo: ratingImageView.centerYAnchor, constant: -2),
        ])
    }
        
    private func setupImageView() {
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.masksToBounds = true
        
        ratingImageView.contentMode = .scaleAspectFill
        ratingImageView.layer.cornerRadius = 10
        ratingImageView.layer.masksToBounds = true
        ratingImageView.image = UIImage(systemName: "star.fill")
        ratingImageView.tintColor = .blue
    }
    
    func configure(with model: Films) {
        titleLabel.text = "\(model.title)"
        releaseLabel.text = "\(model.releaseDate)"
        voteLabel.text = "\(model.voteAverage)"
        let url = URL(string: baseImageUrl.baseImageURL + model.poster)
        posterImageView.sd_setImage(with: url)
    }
    
    private func setupLabel() {
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        releaseLabel.textAlignment = .left
        releaseLabel.textColor = .white
        releaseLabel.numberOfLines = 0
        
        voteLabel.textAlignment = .left
        voteLabel.textColor = .white
        voteLabel.numberOfLines = 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        posterImageView.sd_cancelCurrentImageLoad()
        posterImageView.image = nil
    }
}

