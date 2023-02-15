//
//  OneFilmCollectionView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 19.01.2023.
//

import UIKit
import SDWebImage

class SingleFilmCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Private Properties
    private let posterImageView = UIImageView()
    private let ratingImageView = UIImageView()
    private let titleLabel = UILabel()
    private let releaseLabel = UILabel()
    private let voteLabel = UILabel()
    private let favoriteFilmButton = UIButton()
    private let customBlurEffectViewForFavoriteFilmButton = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    private let customBlurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    
    //MARK: - Public Properties
    var heartTapCellCallBack: (() -> Void)?
    var likeButtonisTepped = Bool()
    
    //MARK: - Lifecycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setup() {
        addSubviews()
        layout()
        setupImageView()
        setupButton()
        setupLabel()
    }
    
    private func addSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(customBlurEffectViewForFavoriteFilmButton)
        contentView.addSubview(favoriteFilmButton)
        contentView.addSubview(customBlurEffectView)
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
        customBlurEffectView.translatesAutoresizingMaskIntoConstraints = false
        customBlurEffectViewForFavoriteFilmButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteFilmButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImageView.widthAnchor.constraint(equalToConstant: 136),
            posterImageView.heightAnchor.constraint(equalToConstant: 204),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 24),
            
            releaseLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            releaseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
            releaseLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 24),
            
            customBlurEffectView.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -4),
            customBlurEffectView.heightAnchor.constraint(equalToConstant: 32),
            customBlurEffectView.widthAnchor.constraint(equalToConstant: 66),
            customBlurEffectView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -4),
            
            customBlurEffectViewForFavoriteFilmButton.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 4),
            customBlurEffectViewForFavoriteFilmButton.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 4),
            customBlurEffectViewForFavoriteFilmButton.heightAnchor.constraint(equalToConstant: 32),
            customBlurEffectViewForFavoriteFilmButton.widthAnchor.constraint(equalToConstant: 32),
            
            favoriteFilmButton.centerYAnchor.constraint(equalTo: customBlurEffectViewForFavoriteFilmButton.centerYAnchor),
            favoriteFilmButton.centerXAnchor.constraint(equalTo: customBlurEffectViewForFavoriteFilmButton.centerXAnchor),
            favoriteFilmButton.heightAnchor.constraint(equalToConstant: 20),
            favoriteFilmButton.widthAnchor.constraint(equalToConstant: 20),
            
            voteLabel.topAnchor.constraint(equalTo: customBlurEffectView.topAnchor, constant: 7),
            voteLabel.trailingAnchor.constraint(equalTo: customBlurEffectView.trailingAnchor, constant: -10),
            voteLabel.bottomAnchor.constraint(equalTo: customBlurEffectView.bottomAnchor, constant: -7),
            
            ratingImageView.leadingAnchor.constraint(equalTo: customBlurEffectView.leadingAnchor, constant: 8),
            ratingImageView.heightAnchor.constraint(equalToConstant: 20),
            ratingImageView.widthAnchor.constraint(equalToConstant: 20),
            ratingImageView.centerYAnchor.constraint(equalTo: voteLabel.centerYAnchor)
        ])
    }
        
    private func setupImageView() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 16
        posterImageView.layer.masksToBounds = true
        
        ratingImageView.contentMode = .scaleAspectFit
        ratingImageView.layer.masksToBounds = true
        ratingImageView.image = UIImage(systemName: "star.fill")
        ratingImageView.tintColor = Colors.accentTextColor
        
        customBlurEffectView.layer.cornerRadius = 16
        customBlurEffectView.layer.masksToBounds = true
        
        customBlurEffectViewForFavoriteFilmButton.layer.cornerRadius = 16
        customBlurEffectViewForFavoriteFilmButton.layer.masksToBounds = true
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentView.layer.shadowRadius = 16
        contentView.layer.masksToBounds = false
    }
    
    private func setupButton() {
        if likeButtonisTepped == true {
            favoriteFilmButton.setImage(UIImage(systemName: "heart.fill"), for: [])
            favoriteFilmButton.contentMode = .scaleAspectFit
            favoriteFilmButton.tintColor = .systemRed
        } else {
            favoriteFilmButton.setImage(UIImage(systemName: "heart"), for: [])
            favoriteFilmButton.contentMode = .scaleAspectFit
            favoriteFilmButton.tintColor = .white
        }
        favoriteFilmButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    private func setupLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 27)
        titleLabel.textAlignment = .left
        titleLabel.textColor = Colors.primaryTextOnSurfaceColor
        titleLabel.numberOfLines = 0
        
        releaseLabel.font = UIFont.systemFont(ofSize: 17)
        releaseLabel.textAlignment = .left
        releaseLabel.textColor = Colors.secondaryTextOnSurfaceColor
        releaseLabel.numberOfLines = 0
        
        voteLabel.font = UIFont.systemFont(ofSize: 15)
        voteLabel.textAlignment = .center
        voteLabel.textColor = Colors.accentTextColor
        voteLabel.numberOfLines = 0
    }
    
    @objc private func didTapFavoriteButton(sender: UIButton) {
        if likeButtonisTepped == false {
            likeButtonisTepped = true
            setupButton()
        } else {
            likeButtonisTepped = false
            setupButton()
        }
        heartTapCellCallBack?()
    }
    
    //MARK: - Public Methods
    func configure(with model: Film, isliked: Bool) {
        titleLabel.text = model.title
        releaseLabel.text = model.releaseDate
        voteLabel.text = "\(model.voteAverage)"
        let url = URL(string: NetworkСonstants.baseImageURL + model.poster)
        posterImageView.sd_setImage(with: url)
        if isliked == false {
            likeButtonisTepped = false
            setupButton()
        } else {
            likeButtonisTepped = true
            setupButton()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        releaseLabel.text = nil
        posterImageView.sd_cancelCurrentImageLoad()
        posterImageView.image = nil
    }
}


