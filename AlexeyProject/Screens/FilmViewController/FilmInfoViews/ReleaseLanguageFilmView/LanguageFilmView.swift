//
//  LanguageFilmView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.02.2023.
//

import UIKit

class LanguageFilmView: UIView {
    
    //MARK: - Public Properties
    var languageLabel = UILabel()
    var languageNameLabel = UILabel()
    
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
        addSubview(languageLabel)
        addSubview(languageNameLabel)
    }
    
    private func setupConstraints() {
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            languageNameLabel.topAnchor.constraint(equalTo: topAnchor),
            languageNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            languageNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            languageNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            languageLabel.topAnchor.constraint(equalTo: languageNameLabel.bottomAnchor, constant: 4),
            languageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            languageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            languageLabel.heightAnchor.constraint(equalToConstant: 24),
            languageLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupLabel() {
        languageLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        languageLabel.textColor = Colors.primaryTextOnSurfaceColor
        languageLabel.textAlignment = .left
        languageLabel.numberOfLines = 0
        
        languageNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        languageNameLabel.textColor = Colors.primaryTextOnSurfaceColor
        languageNameLabel.textAlignment = .left
        languageNameLabel.numberOfLines = 0
    }
}
