//
//  CountryInfoFilmView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 12.02.2023.
//

import UIKit

class CountryInfoFilmView: UIView {
    
    //MARK: - Public Properties
    var countryLabel = UILabel()
    
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
        addSubview(countryLabel)
    }
    
    private func setupConstraints() {
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: topAnchor),
            countryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countryLabel.heightAnchor.constraint(equalToConstant: 20),
            countryLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupLabel() {
        countryLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        countryLabel.textColor = Colors.primaryTextOnSurfaceColor
        countryLabel.textAlignment = .left
        countryLabel.numberOfLines = 0
    }
}
