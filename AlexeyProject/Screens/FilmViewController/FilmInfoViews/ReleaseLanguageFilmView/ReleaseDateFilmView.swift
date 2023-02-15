//
//  ReleaseDateFilmView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.02.2023.
//

import UIKit

class ReleaseDateFilmView: UIView {
    
    //MARK: - Public Properties
    var releaseLabel = UILabel()
    var releaseNameLabel = UILabel()
    
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
        setupConstraints()
        setupLabel()
    }
    
    private func addSubviews() {
        addSubview(releaseLabel)
        addSubview(releaseNameLabel)
    }
    
    private func setupConstraints() {
        releaseLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            releaseNameLabel.topAnchor.constraint(equalTo: topAnchor),
            releaseNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            releaseNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            releaseNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            releaseLabel.topAnchor.constraint(equalTo: releaseNameLabel.bottomAnchor, constant: 4),
            releaseLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            releaseLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            releaseLabel.heightAnchor.constraint(equalToConstant: 24),
            releaseLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupLabel() {
        releaseLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        releaseLabel.textColor = Colors.primaryTextOnSurfaceColor
        releaseLabel.textAlignment = .left
        releaseLabel.numberOfLines = 0
        
        releaseNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        releaseNameLabel.textColor = Colors.primaryTextOnSurfaceColor
        releaseNameLabel.textAlignment = .left
        releaseNameLabel.numberOfLines = 0
    }
}


