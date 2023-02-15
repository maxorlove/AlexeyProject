//
//  PosterFilmImageView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 12.02.2023.
//

import UIKit
import SDWebImage

class PosterFilmImageView: UIView {
    
    // MARK: - Public Properties
    var posterImageView = UIImageView()
    var posterBackGroundImageView = UIImageView()
    var likeButtonisTepped = Bool()
    var heartTapCallBack: (() -> Void)?
    
    // MARK: - Private Properties
    private let favoriteFilmButton = UIButton()
    var favoriteFilmButtonImageView = UIImageView()
    private let customBlurEffectViewForFavoriteFilmButton = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
    private let customBlurEffectViewForFilm = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Private Methods
    private func setup() {
        addSubviews()
        setupConstraints()
        setupImageView()
        shadowEffect()
        setupView()
        setupButton()
    }
    
    private func addSubviews() {
        addSubview(posterBackGroundImageView)
        addSubview(customBlurEffectViewForFilm)
        addSubview(posterImageView)
        addSubview(customBlurEffectViewForFavoriteFilmButton)
        addSubview(favoriteFilmButton)
        addSubview(favoriteFilmButtonImageView)
    }
    
    private func setupConstraints() {
        posterBackGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteFilmButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteFilmButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        customBlurEffectViewForFavoriteFilmButton.translatesAutoresizingMaskIntoConstraints = false
        customBlurEffectViewForFilm.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterBackGroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterBackGroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterBackGroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterBackGroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            customBlurEffectViewForFilm.topAnchor.constraint(equalTo: topAnchor),
            customBlurEffectViewForFilm.leadingAnchor.constraint(equalTo: posterBackGroundImageView.leadingAnchor),
            customBlurEffectViewForFilm.trailingAnchor.constraint(equalTo: posterBackGroundImageView.trailingAnchor),
            customBlurEffectViewForFilm.bottomAnchor.constraint(equalTo: posterBackGroundImageView.bottomAnchor),

            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            posterImageView.leadingAnchor.constraint(equalTo: posterBackGroundImageView.leadingAnchor, constant: 57),
            posterImageView.trailingAnchor.constraint(equalTo: posterBackGroundImageView.trailingAnchor, constant: -56),
            posterImageView.heightAnchor.constraint(equalToConstant: 396),
            
            customBlurEffectViewForFavoriteFilmButton.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 296),
            customBlurEffectViewForFavoriteFilmButton.trailingAnchor.constraint(equalTo: posterBackGroundImageView.trailingAnchor, constant: -24),
            customBlurEffectViewForFavoriteFilmButton.heightAnchor.constraint(equalToConstant: 56),
            customBlurEffectViewForFavoriteFilmButton.widthAnchor.constraint(equalToConstant: 56),
            
            favoriteFilmButton.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 296),
            favoriteFilmButton.trailingAnchor.constraint(equalTo: posterBackGroundImageView.trailingAnchor, constant: -24),
            favoriteFilmButton.heightAnchor.constraint(equalTo: customBlurEffectViewForFavoriteFilmButton.heightAnchor),
            favoriteFilmButton.widthAnchor.constraint(equalTo: customBlurEffectViewForFavoriteFilmButton.widthAnchor),
            
            favoriteFilmButtonImageView.heightAnchor.constraint(equalToConstant: 24),
            favoriteFilmButtonImageView.widthAnchor.constraint(equalToConstant: 24),
            favoriteFilmButtonImageView.centerXAnchor.constraint(equalTo: favoriteFilmButton.centerXAnchor),
            favoriteFilmButtonImageView.centerYAnchor.constraint(equalTo: favoriteFilmButton.centerYAnchor),
        ])
    }
    
    private func setupImageView() {
        posterBackGroundImageView.contentMode = .scaleAspectFill
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 12
        posterImageView.layer.masksToBounds = true
        
        favoriteFilmButtonImageView.contentMode = .scaleAspectFit
        favoriteFilmButtonImageView.tintColor = Colors.primaryTextOnSurfaceColor
    }
    
    private func setupView() {
        customBlurEffectViewForFilm.contentMode = .scaleAspectFill

        customBlurEffectViewForFavoriteFilmButton.layer.cornerRadius = 20
        customBlurEffectViewForFavoriteFilmButton.clipsToBounds = true
    }
    
    private func setupButton() {
        if likeButtonisTepped == true {
            favoriteFilmButton.backgroundColor = Colors.primaryBackGroundColor?.withAlphaComponent(0.5)
            favoriteFilmButton.layer.cornerRadius = 20
            favoriteFilmButton.layer.masksToBounds = true
            favoriteFilmButtonImageView.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        } else {
            favoriteFilmButton.backgroundColor = Colors.primaryBackGroundColor?.withAlphaComponent(0.5)
            favoriteFilmButton.layer.cornerRadius = 20
            favoriteFilmButton.layer.masksToBounds = true
            favoriteFilmButtonImageView.image = UIImage(named: "dislike")?.withRenderingMode(.alwaysTemplate)
        }
        favoriteFilmButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    private func shadowEffect() {
        favoriteFilmButton.layer.shadowColor = UIColor.black.cgColor
        favoriteFilmButton.layer.shadowOpacity = 0.4
        favoriteFilmButton.layer.shadowOffset = CGSize.zero
        favoriteFilmButton.layer.shadowRadius = 20
        favoriteFilmButton.layer.masksToBounds = false
    }
    
    @objc private func didTapFavoriteButton(sender: UIButton) {
        if likeButtonisTepped == false {
            likeButtonisTepped = true
            setupButton()
        } else {
            likeButtonisTepped = false
            setupButton()
        }
        heartTapCallBack?()
    }
}





