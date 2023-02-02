//
//  PosterImageView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 22.01.2023.
//

import UIKit
import SDWebImage
class PosterImageView: UIView {
    
    // MARK: - Properties
    var posterImageView = UIImageView()
    var ratingImageView = UIImageView()
    var voteLabel = UILabel()
    var posterBackGroundImageView = UIImageView()
    private let customBlurEffectViewForFilm = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let customBlurEffectViewForVote = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Methods
    private func setup() {
        addSubviews()
        setupConstraints()
        setupImageView()
        setupLabel()
    }
    
    private func addSubviews() {
        addSubview(posterBackGroundImageView)
        addSubview(customBlurEffectViewForFilm)
        addSubview(posterImageView)
        addSubview(customBlurEffectViewForVote)
        addSubview(ratingImageView)
        addSubview(voteLabel)
    }
    
    private func setupConstraints() {
        posterBackGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        customBlurEffectViewForFilm.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        customBlurEffectViewForVote.translatesAutoresizingMaskIntoConstraints = false
        ratingImageView.translatesAutoresizingMaskIntoConstraints = false
        voteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterBackGroundImageView.topAnchor.constraint(equalTo: topAnchor),
            posterBackGroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterBackGroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterBackGroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            customBlurEffectViewForFilm.topAnchor.constraint(equalTo: posterBackGroundImageView.topAnchor),
            customBlurEffectViewForFilm.leadingAnchor.constraint(equalTo: posterBackGroundImageView.leadingAnchor),
            customBlurEffectViewForFilm.trailingAnchor.constraint(equalTo: posterBackGroundImageView.trailingAnchor),
            customBlurEffectViewForFilm.bottomAnchor.constraint(equalTo: posterBackGroundImageView.bottomAnchor),

            posterImageView.topAnchor.constraint(equalTo: posterBackGroundImageView.topAnchor, constant: 24),
            posterImageView.leadingAnchor.constraint(equalTo: posterBackGroundImageView.leadingAnchor, constant: 48),
            posterImageView.trailingAnchor.constraint(equalTo: posterBackGroundImageView.trailingAnchor, constant: -48),
            posterImageView.heightAnchor.constraint(equalToConstant: 445),
            posterImageView.widthAnchor.constraint(equalToConstant: 287),
            
            customBlurEffectViewForVote.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 4),
            customBlurEffectViewForVote.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -4),
            customBlurEffectViewForVote.heightAnchor.constraint(equalToConstant: 32),
            customBlurEffectViewForVote.widthAnchor.constraint(equalToConstant: 85),
            
            voteLabel.topAnchor.constraint(equalTo: customBlurEffectViewForVote.topAnchor, constant: 7),
            voteLabel.trailingAnchor.constraint(equalTo: customBlurEffectViewForVote.trailingAnchor, constant: -10),
            voteLabel.bottomAnchor.constraint(equalTo: customBlurEffectViewForVote.bottomAnchor, constant: -7),
            
            ratingImageView.leadingAnchor.constraint(equalTo: customBlurEffectViewForVote.leadingAnchor, constant: 9.67),
            ratingImageView.heightAnchor.constraint(equalToConstant: 16.67),
            ratingImageView.widthAnchor.constraint(equalToConstant: 16.67),
            ratingImageView.centerYAnchor.constraint(equalTo: voteLabel.centerYAnchor)
        ])
    }
    
    private func setupImageView() {
        posterBackGroundImageView.contentMode = .scaleAspectFill
        customBlurEffectViewForFilm.contentMode = .scaleAspectFill
        customBlurEffectViewForVote.layer.cornerRadius = 16
        customBlurEffectViewForVote.clipsToBounds = true
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 16
        posterImageView.layer.masksToBounds = true
        
        ratingImageView.contentMode = .scaleAspectFill
        ratingImageView.image = UIImage(systemName: "star.fill")
        ratingImageView.tintColor = Colors.accentTextColor
    }
    
    private func setupLabel() {
        voteLabel.font = UIFont.systemFont(ofSize: 16)
        voteLabel.textAlignment = .center
        voteLabel.textColor = Colors.accentTextColor
        voteLabel.numberOfLines = 1
    }
}




