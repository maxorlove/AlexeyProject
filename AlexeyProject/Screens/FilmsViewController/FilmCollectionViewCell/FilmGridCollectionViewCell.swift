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
    private let customBlurEffectViewForVote = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let customBlurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
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
    }
    
    private func addSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(customBlurEffectView)
        contentView.addSubview(customBlurEffectViewForVote)
        contentView.addSubview(ratingImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(voteLabel)
    }
    
    private func layout(){
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        customBlurEffectViewForVote.translatesAutoresizingMaskIntoConstraints = false
        customBlurEffectView.translatesAutoresizingMaskIntoConstraints = false
        ratingImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        voteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            customBlurEffectView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor,constant: 4),
            customBlurEffectView.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor,constant: -4),
            customBlurEffectView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -4),
            customBlurEffectView.heightAnchor.constraint(equalToConstant: 64),
            customBlurEffectView.widthAnchor.constraint(equalToConstant: 177),
            
            titleLabel.topAnchor.constraint(equalTo: customBlurEffectView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: customBlurEffectView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: customBlurEffectView.trailingAnchor, constant: -12),
            
            customBlurEffectViewForVote.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 4),
            customBlurEffectViewForVote.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -4),
            customBlurEffectViewForVote.heightAnchor.constraint(equalToConstant: 32),
            customBlurEffectViewForVote.widthAnchor.constraint(equalToConstant: 66),
            
            voteLabel.topAnchor.constraint(equalTo: customBlurEffectViewForVote.topAnchor, constant: 7),
            voteLabel.trailingAnchor.constraint(equalTo: customBlurEffectViewForVote.trailingAnchor, constant: -10),
            voteLabel.bottomAnchor.constraint(equalTo: customBlurEffectViewForVote.bottomAnchor, constant: -7),
            
            ratingImageView.leadingAnchor.constraint(equalTo: customBlurEffectViewForVote.leadingAnchor, constant: 10),
            ratingImageView.heightAnchor.constraint(equalToConstant: 17),
            ratingImageView.widthAnchor.constraint(equalToConstant: 17),
            ratingImageView.centerYAnchor.constraint(equalTo: voteLabel.centerYAnchor)
        ])
    }
        
    private func setupImageView() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 12
        posterImageView.layer.masksToBounds = true
        posterImageView.backgroundColor = .clear
        
        ratingImageView.contentMode = .scaleAspectFill
        ratingImageView.image = UIImage(systemName: "star.fill")
        ratingImageView.tintColor = Colors.accentTextColor
        
        customBlurEffectViewForVote.layer.cornerRadius = 12
        customBlurEffectView.layer.cornerRadius = 13
        customBlurEffectViewForVote.clipsToBounds = true
        customBlurEffectView.clipsToBounds = true
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize.zero
        contentView.layer.shadowRadius = 12
        contentView.layer.masksToBounds = false
    }
    
    func configure(with model: Film) {
        titleLabel.text = model.title
        releaseLabel.text = model.releaseDate
        voteLabel.text = "\(model.voteAverage)"
        let url = URL(string: baseImageUrl.baseImageURL + model.poster)
        posterImageView.sd_setImage(with: url)
    }
    
    private func setupLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        titleLabel.textColor = Colors.accentTextColor
        titleLabel.numberOfLines = 2
        
        voteLabel.font = UIFont.systemFont(ofSize: 15)
        voteLabel.textAlignment = .center
        voteLabel.textColor = Colors.accentTextColor
        voteLabel.numberOfLines = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        posterImageView.sd_cancelCurrentImageLoad()
        posterImageView.image = nil
    }
}

