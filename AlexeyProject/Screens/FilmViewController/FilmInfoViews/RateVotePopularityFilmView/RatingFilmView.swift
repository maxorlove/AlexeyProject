//
//  RatingFilmImageView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.02.2023.
//

import UIKit

class RatingFilmView: UIView {
    
    //MARK: - Public Properties
    var ratingLabel = UILabel()
    var ratingNameLabel = UILabel()
    var starImageView = UIImageView()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Private Methods
    private func setup() {
        addSubviews()
        setupView()
        setupConstraints()
        setupLabel()
        setupImage()
    }
    
    private func addSubviews() {
        addSubview(ratingLabel)
        addSubview(ratingNameLabel)
        addSubview(starImageView)
    }
    
    private func setupConstraints() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingNameLabel.translatesAutoresizingMaskIntoConstraints = false
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            starImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            starImageView.heightAnchor.constraint(equalToConstant: 24),
            starImageView.widthAnchor.constraint(equalToConstant: 24),
            
            ratingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 12),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            ratingNameLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
            ratingNameLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 12),
            ratingNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            ratingNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
        ])
    }
    
    private func setupView() {
        backgroundColor = Colors.rateBackGroundColor
        layer.cornerRadius = 24
        layer.masksToBounds = true
    }
    
    private func setupLabel() {
        ratingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        ratingLabel.textColor = Colors.primaryTextOnSurfaceColor
        ratingLabel.textAlignment = .left
        ratingLabel.numberOfLines = 0
        
        ratingNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        ratingNameLabel.textColor = Colors.primaryTextOnSurfaceColor
        ratingNameLabel.textAlignment = .left
        ratingNameLabel.numberOfLines = 0
    }
    
    private func setupImage() {
        starImageView.contentMode = .scaleAspectFit
        starImageView.layer.masksToBounds = true
        starImageView.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        starImageView.tintColor = Colors.primaryTextOnSurfaceColor
    }
}


