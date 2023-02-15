//
//  CountryFilmView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.02.2023.
//

import UIKit

class CountryFilmView: UIView {
    
    //MARK: - Public Properties
    var countryNameLabel = UILabel()
    var countryStackView = UIStackView()
    
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
        setupStackView()
    }
    
    private func addSubviews() {
        addSubview(countryNameLabel)
        addSubview(countryStackView)
    }
    
    private func setupConstraints() {
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countryNameLabel.topAnchor.constraint(equalTo: topAnchor),
            countryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countryNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countryNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            countryStackView.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 4),
            countryStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            countryStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            countryStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupLabel() {
        countryNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        countryNameLabel.textColor = Colors.primaryTextOnSurfaceColor
        countryNameLabel.textAlignment = .left
        countryNameLabel.numberOfLines = 0
    }
    
    private func setupStackView() {
        countryStackView.axis = .vertical
        countryStackView.spacing = 8
        countryStackView.distribution = .fillEqually
        countryStackView.alignment = .fill
        countryStackView.isLayoutMarginsRelativeArrangement = true
    }
}

