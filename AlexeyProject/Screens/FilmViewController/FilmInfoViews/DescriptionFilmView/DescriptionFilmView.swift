//
//  DescriptionFilmView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.02.2023.
//

import UIKit

class DescriptionFilmView: UIView {
    
    //MARK: - Public Properties
    var filmDescriptionLabel = UILabel()
    
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
        addSubview(filmDescriptionLabel)
    }
    
    private func setupConstraints() {
        filmDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filmDescriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            filmDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            filmDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            filmDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupLabel() {
        filmDescriptionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        filmDescriptionLabel.textColor = Colors.primaryTextOnSurfaceColor
        filmDescriptionLabel.textAlignment = .left
        filmDescriptionLabel.numberOfLines = 0
    }
}


