//
//  FilmLabelView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.02.2023.
//

import UIKit

class FilmLabelView: UIView {
    
    //MARK: - Public Properties
    var filmTitleLabel = UILabel()
    
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
        addSubview(filmTitleLabel)
    }
    
    private func setupConstraints() {
        filmTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filmTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            filmTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            filmTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            filmTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupLabel() {
        filmTitleLabel.font = UIFont.systemFont(ofSize: 37, weight: .bold)
        filmTitleLabel.textColor = Colors.primaryTextOnSurfaceColor
        filmTitleLabel.textAlignment = .left
        filmTitleLabel.numberOfLines = 0
    }
}

